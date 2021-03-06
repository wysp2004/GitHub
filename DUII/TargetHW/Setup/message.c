// Part of traqmate.c
// 3/10/2004
// Author: BLBoyer
// Modified for traqmate: GAStephens, 3/24/2004
// added opcode return to ParseMessage 7/29/04
// added sw download: JPaulos, GAStephens 4/28/05
//
// This file contains the routines to format and send coded messages
// between the Traqmate and Traqview software.
//

#include <math.h>
#include "GUI_Type.h"
#include "DUII.h"
#include "CommTask.h"
#include "DataHandler.h"
#include "LEDHandler.h"
#include "tmtypes.h"
#include "datadecode.h"
#include "dataflash.h"
#include "InterTask.h"
#include "FlashReadWrite.h"
#include "dbgu.h"

//
//	Global Resources
//
extern OS_RSEMA SEMA_GlobalData;			// resource semaphore around global data
extern void reset(void);
void mSDelay(int);
void uSDelay(int);
extern OS_Q Queue_tqm;						// file queue

//
// Constants
//
#define SPEED_HYSTERESIS		10.0		// speed must change by 6 kph to record vmax or vmin

//
// External data declarations
//

#define SendACK_Data(DEST, LEN) SendMessage(msgrouting[0], (u08) DEST, (u08) ACK,(LEN))
#define SendACK(DEST) SendACK_Data(DEST, 0)

// The following function gets passed all the input data
// necessary to build a complete message. For efficiency it does not
// get passed the data buffer itself.
// In addition to being passed the data, the function will also
// call supporting functions to calculate checksums for the header
// and if appropriate, crc's for the data portion of the message

s16 SendMessage(	u08 source,		// unit id of source
					u08 dest,		// unit id of destination
			 		u08 opcode,		// message opcode
					u16 bytes)	{	// number of bytes to transmit
	u08 sendchk;					// used to start the header checksum calculation
	u16 i = 0;						// general index
	u16 crc = 0;					// used to hold the calculated CRC
	u08 port = msgrouting[dest];

	// start timeout
	OS_RetriggerTimer(&(COMMCTSTIMERS[dest-1]));
	COMMCTS[dest-1] = CTS_COUNTDOWN;

	// record this message as outstanding if from this device
	if (source == msgrouting[0] && opcode != ACK && opcode != NAK)
		outstanding_msg[dest-1] = opcode;

	sendchk = 0xFF;						// initialize
	
	com[port].txbuff[START] = SOH ;  // start of header
	com[port].txbuff[SOURCE] = source; // source of the message
	com[port].txbuff[DESTINATION] = dest; // destination of the message (same as above)

	bytes += 2;					// add two bytes to the total for the CRC

	com[port].txbuff[UPPER_BYTE_COUNT] = (bytes & 0xff00)>>8 ;  // format byte count to
	com[port].txbuff[LOWER_BYTE_COUNT] = bytes & 0xff;          // two byte field

	com[port].txbuff[OPCODE]=opcode ;	// store the message op code
	
	for (i=0; i<CHECKSUM;i++)	// calculate the message header checksum
		sendchk ^= com[port].txbuff[i] ;		// over all bytes from SOH through op code
	
	com[port].txbuff[CHECKSUM] = sendchk ;	// store the checksum in final header byte

	bytes -= 2;					// remove crc from total

	crc = crc16(&(com[port].txbuff[DATA_START]),bytes);	// calculate the crc

	com[port].txbuff[++bytes+CHECKSUM] = (crc & 0xff00)>>8 ;		// store the high crc byte
	com[port].txbuff[++bytes+CHECKSUM] = (crc & 0xff) ;			// store the low crc byte

//	App_putstring(com[port].txbuff, (DATA_START+bytes));
	XmitUART(&(com[port]), DATA_START+bytes);						// send it
	return((s16) DATA_START+bytes) ;  // return total number of bytes processed in message

} // SendMessage

// the following routine will parse a message based on the op code
// it is up to the opcode to determine any additional processing, such as
// CRC calculations, or the meaning of the data
#define G_FILTER_VAL		5	// number of samples over which to average G force, 3-5 is good
#define HEADING_FILTER_VAL	4	// number of samples over which to average heading

s16 Parse_Message(u08 port, u08 *msgptr)
{
	s16 retval = 0 ;
	u16 msgdatalen;
	static int gcnt = 0;		// how many tenths into a sample
	static int iocnt = 0;		// how many io points have been saved during this sample
	static int inhighrev;		// indicates we are in the middle of an overrev condition
	static int inoverrev;		// indicates we are in the middle of an overrev condition
	static float lastspeed = 0.0;		// last speed sample
	static int speedincreasing;	// true if speed is increasing, false if decreasing
	static float xgrolling[G_FILTER_VAL];
	static float ygrolling[G_FILTER_VAL];
	static float zgrolling[G_FILTER_VAL];
	static int grollingidx;		// index into latest value in rolling g value table used for filtering
	static int zrollingidx;		// index into latest value in rolling z axis g value table used for filtering
	static BOOL analogsinitialized = FALSE;		// used to know when to prime the filtering algorithm
	
	msgdatalen = (msgptr[UPPER_BYTE_COUNT] << 8);
	msgdatalen = msgdatalen + msgptr[LOWER_BYTE_COUNT];
	msgdatalen = msgdatalen - 2;

	retval = Verify_CRC(msgptr+DATA_START, msgdatalen);

	if (retval) {		// bad data
		if (NAK != msgptr[OPCODE] && ACK != msgptr[OPCODE])	{ // don't NAK an ACK or NAK
			// grab the port
			COMMCTS[msgptr[SOURCE]-1] = CTS_COUNTDOWN;

			retval = SendNAK(msgptr[SOURCE], (u08) BAD_CRC);		// no data is returned and no crc
		} // if
	} // if
	else {		// message is good so parse it
		int i;
		u08 *tmpfrom;
		u08 *tmpto;

		// if message from SU indicate it is present
		if (SENSOR_UNIT == msgptr[SOURCE]) {
			suData.suPresent = TRUE;
		} // if
		
		// if message not for me, then route it
		if (msgptr[DESTINATION] != msgrouting[0] && msgptr[DESTINATION] != ANY_UNIT) {
			// copy message into appropriate outbound buffer

		// copy into output buffer
		tmpto = com[msgrouting[msgptr[DESTINATION]]].txbuff+DATA_START;
		tmpfrom = msgptr+DATA_START;
		for (i=0; i<msgdatalen; i++)
			*tmpto++ = *tmpfrom++;

			SendMessage(msgptr[SOURCE], msgptr[DESTINATION], msgptr[OPCODE], msgdatalen);
		} // if
		else {	// message for me so process it
			switch (msgptr[OPCODE]) {
			case ACK:

				// if ACK with data then parse the results
				if (SCRATCHLEN == msgdatalen) {
					// must have received a scratchpad buffer
					int tmpctr;

					// save the config data in RAM
					for (tmpctr = 0; tmpctr < SCRATCHLEN; tmpctr++)
						scratchpad.scratchbuff[tmpctr] = msgptr[DATA_START + tmpctr];
					gotscratchpad = TRUE;
				} // if

				// clear the message as outstanding from this device
				outstanding_msg[msgptr[SOURCE]-1] = 0;

				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;

			case NAK:
				// fall back and retry PUT CODE HERE

				// clear the message as outstanding from this device
				outstanding_msg[msgptr[SOURCE-1]] = 0;

				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;

		// the SendACK function should be called within each
		// case to ensure the appropriate data is returned for
		// the corresponding op code
			case WHO_ARE_YOU:
				if (DU2_OCCUPIED(unsavedSysData.systemMode))
					retval = SendNAK(msgptr[SOURCE], (u08) UNIT_BUSY);
				else
					retval = SendACK(msgptr[SOURCE]);
				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;
	
			case READ_SEGMENT: {			// get specified segment data
				int segnum;				// segment number to get

				if (DU2_OCCUPIED(unsavedSysData.systemMode))
					retval = SendNAK(msgptr[SOURCE], (u08) UNIT_BUSY);
				else {
					segnum = (msgptr[DATA_START]<<8) + msgptr[DATA_START+1];

					DataFlash_Page_Read(0, unsavedSysData.dataflash[0].bytesPerPage, (char *) com[0].txbuff+DATA_START, segnum);
					retval = SendACK_Data(msgptr[SOURCE], unsavedSysData.dataflash[0].bytesPerPage);  // send the segment data
				} // else
				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;
			} // READ_SEGMENT
			
			case WRITE_SEGMENT: {			// write data to specified segment
				int segnum;

				if (DU2_OCCUPIED(unsavedSysData.systemMode))
					retval = SendNAK(msgptr[SOURCE], (u08) UNIT_BUSY);
				else {
					segnum = (msgptr[DATA_START]<<8) + msgptr[DATA_START+1];

					DataFlash_Page_Write_Erase(0, GENBUFFER, unsavedSysData.dataflash[0].bytesPerPage, (char *) msgptr+DATA_START+2, segnum);
					
					retval = SendACK(msgptr[SOURCE]);
				} // else
				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;
			} // WRITE_SEGMENT
			
			case READ_UNIT_INFO: {		// gets the factory calibration data
				if (DU2_OCCUPIED(unsavedSysData.systemMode))
					retval = SendNAK(msgptr[SOURCE], (u08) UNIT_BUSY);
				else {
//					ReadScratchpad(com[port].txbuff+DATA_START);
					retval = SendACK_Data(msgptr[SOURCE], SCRATCHLEN);  // send the segment data
				} // else

				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;
			} // READ_UNIT_INFO
			
			case WRITE_UNIT_INFO: {		// writes the factory calibration data
				if (DU2_OCCUPIED(unsavedSysData.systemMode))
					retval = SendNAK(msgptr[SOURCE], (u08) UNIT_BUSY);
				else {
//					EraseScratchpad();
//					WriteScratchpad( msgptr+DATA_START, MIN(msgdatalen, SCRATCHLEN));

					// replenish local copy
//					ReadScratchpad(scratchpad.scratchbuff);

					retval = SendACK(msgptr[SOURCE]);
				} // else

				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;
			} // WRITE_UNIT_INFO
				
				
			case RESET_UNIT: {
				retval = SendACK(msgptr[SOURCE]);
				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;

				reset();
				
				break;
			} // RESET_UNIT

			case DATAFLASHTEST:
			case DATAFLASHTEST2:
				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				
				DataflashTest((int) msgptr[OPCODE], 1);
				break;

			case POWER_DOWN: {
//				int shutdowntime;

				// SU has detected power failure and notified the DU

// *** GAS TEST
//	shutdowntime = OS_GetTime32();

				// change global state
				unsavedSysData.systemMode = DU2_POWERLOSS;
					
				// shut down backlight and LEDs to save power
				LEDSystemShutdown();

				// close data file and save data
				if (NULL != sessionFile) {
					FS_FClose(sessionFile);
					FS_Sync("");
					sessionFile = NULL;
				} // if
				
// *** WORK alternative if there is enough time
//				notifyTQM (DU2_POWER_LOSS);		
//				OS_SetPriority( &TQMWriteTCB, 200);						// make tqm task run

// *** WORK maybe a bad idea if running out of juice

//	time1 = OS_GetTime32() - shutdowntime;

				// save configuration
				WriteDataStructures(SYSTEM_DATA);
				OS_SetPriority( &SDcardRWTCB, 190);						// make tqm task run
				OS_WakeTask(&SDcardRWTCB);
				
//	time2 = OS_GetTime32() - shutdowntime;

				OS_Delay(2000);			// allow other tasks to do their work

				// I'm not dead yet? Then just go away.
				while (1) {
					// tell SU to shut us down
					SendMessage((u08) DISPLAY_UNIT, (u08) SENSOR_UNIT, (u08) POWER_DOWN, (u08) 0);

					// wait a bit. if still alive, send it again
					OS_Delay( 1000 );
				} // while
			} // POWER_DOWN

			case WRITE_DISPLAY_TEXT: {

				// put in code to write a line of text to screen
//				Write_Line((u08) 3, msgptr+DATA_START, TRUE, '-');		
				retval = SendACK(msgptr[SOURCE]);

				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;
				break;
			} // WRITE_DISPLAY_TEXT
			case CAM_STATUS: {
				// ignore pesky messages during startup
//				if (DU2_STARTUP != unsavedSysData.systemMode) {
					
					retval = SendACK(msgptr[SOURCE]);

					// free up unit for more communications
					COMMCTS[msgptr[SOURCE]-1] = 0;

					if ((CAMERA_NONE != vehicleData.camera) || (CAMERA_USB != vehicleData.camera)) {
						// first byte has camera status
						pdrlancstatus = (pdrlancstatustype) (msgptr[DATA_START]);
						
						switch (pdrlancstatus) {
							case PDROFF:
							case PDRLANCNOTREADY:
							case PDRLANC2WIRE:
								DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_NOT_READY;
								break;					
							case PDRLANCREADY:
								DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_READY;
								break;
							case PDRLANCRECORD:
								DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_RECORDING;
								break;
							case UNKNOWN:
							case PDRLANCNOTCONNECTED:
							default:
								DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_NOT_CONNECTED;
						} // switch
					} // if
//				} // if
				break;
			} // PDR_STATUS				
			case GPS_DATA: {
				s16 eastvel, northvel, vertvel;
				float tempfloat;
				int idx;
				s32 temp;
				
				// ACK the message
				retval = SendACK(msgptr[SOURCE]);

				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;

				OS_Use(&SEMA_GlobalData);

				// first byte tells whether position data is good
				DataValues[GPS_NUMSAT].uVal = msgptr[DATA_START];
				if (DataValues[GPS_NUMSAT].uVal < DataValues[MIN_SATS].uVal)
					DataValues[MIN_SATS].uVal = MAX(GPS_GOOD, DataValues[GPS_NUMSAT].uVal);

				if (DataValues[GPS_NUMSAT].uVal > DataValues[MAX_SATS].uVal)
					DataValues[MAX_SATS].uVal = DataValues[GPS_NUMSAT].uVal;

				// relinquish global data
				OS_Unuse(&SEMA_GlobalData);		

				// store the gps position data into the buffer
				// done with or without gpslock because su will interpolate
				tqmsample.secsamp.gps = *((gpstype *)(msgptr+DATA_START+1));
				
				if (suData.suHwRev >= 200) {		// only do this if we are connected to 3 axis SU2

					tempfloat = (float) (u08) tqmsample.secsamp.gps.temp - accelz.zero;
					if (tempfloat < 0.0) {
						DataValues[Z_G].fVal = tempfloat / (accelz.zero - accelz.min);
					} // if
					else  {
						DataValues[Z_G].fVal = tempfloat / (accelz.max - accelz.zero);
					} // else
					
					// update indices for rolling filter history				
					zrollingidx = (1+zrollingidx) % G_FILTER_VAL;
					
					// put z value in rolling table
					zgrolling[zrollingidx] = DataValues[Z_G].fVal;
					
					// update the filtered G values
					tempfloat = 0.0;
					for (idx = 0; idx < G_FILTER_VAL; idx++) {
						tempfloat += zgrolling[idx];
					} // for
					
					DataValues[Z_G_DAMPED].fVal = tempfloat / (float) G_FILTER_VAL;

					// set the peaks using the filtered values
					if (DataValues[Z_G_DAMPED].fVal > DataValues[MAX_Z_G].fVal)
						DataValues[MAX_Z_G].fVal = DataValues[Z_G_DAMPED].fVal;
					if (DataValues[Z_G_DAMPED].fVal < DataValues[MIN_Z_G].fVal)
						DataValues[MIN_Z_G].fVal = DataValues[Z_G_DAMPED].fVal;
				} // if
				else {					// original 2 axis SU1
					DataValues[SU_TEMPERATURE].fVal = dotemp(tqmsample.secsamp.gps.temp, 'C');
				} // else				
				
				if (DataValues[GPS_NUMSAT].uVal >= GPS_GOOD) {
					// update global time if good value received
					if (0 != tqmsample.secsamp.gps.time && 0xFFFFFFFF != tqmsample.secsamp.gps.time) {
						// save first good week as starting week
						if (0 != tqmsample.secsamp.gps.weeks && 0xFFFF != tqmsample.secsamp.gps.weeks) {
						// write global time
						// request use of global data
						OS_Use(&SEMA_GlobalData);

						DataValues[GPS_WEEKS].iVal = SWAP16(tqmsample.secsamp.gps.weeks);
						DataValues[GPS_TIME].iVal = SWAP32(tqmsample.secsamp.gps.time);					
								
						// relinquish global data
						OS_Unuse(&SEMA_GlobalData);							
						
						} // if
					} // if
					
					// get the speed vectors
					unpack_velocities ((void *)&(tqmsample.secsamp.gps.velpack[0]), &eastvel, &northvel, &vertvel);
		
					// request use of global data
					OS_Use(&SEMA_GlobalData);				
					
					// use temp to preserve sign
					temp = SWAP32(tqmsample.secsamp.gps.lat);
					DataValues[LATITUDE].dVal = ((double) temp * 180.0) / GPSINTEGERTOFLOAT;
					temp = SWAP32(tqmsample.secsamp.gps.lon);
					DataValues[LONGITUDE].dVal = ((double) temp * 180.0) / GPSINTEGERTOFLOAT;					
	
					// calculate speed in kph times fudge factor
					DataValues[SPEED].fVal = (double) (3600.0 / 1000.0) * GPSVELSCALE * sqrt(((double) eastvel * (double) eastvel + (double) northvel * (double) northvel));

					// only calculate heading if moving
					if (DataValues[SPEED].fVal >= 1.0)
						DataValues[HEADING].fVal = compute_heading(eastvel, northvel);
					
					// look for vmax and vmin
					if (speedincreasing) { // previously speed was climbing
						if (DataValues[SPEED].fVal < (lastspeed - SPEED_HYSTERESIS)) {
							// speed was rising and is now falling so record VMAX
							DataValues[VMAX].fVal = lastspeed;
							DataValues[SPEED_PEAKS].fVal = lastspeed;
							speedincreasing = false;
							lastspeed = DataValues[SPEED].fVal;
						} // if
						else {
							// bump top speed if new speed is higher
							if (DataValues[SPEED].fVal > lastspeed)
								lastspeed = DataValues[SPEED].fVal;
						} // else
					} // if
					else {		// previously speed was falling
						if (DataValues[SPEED].fVal > (lastspeed + SPEED_HYSTERESIS)) {
							// speed was falling and is now rising so record VMIN
							DataValues[VMIN].fVal = lastspeed;
							DataValues[SPEED_PEAKS].fVal = -lastspeed;
							speedincreasing = true;
							lastspeed = DataValues[SPEED].fVal;
						} // if
						else {
							// bump low speed if new speed is lower
							if (DataValues[SPEED].fVal < lastspeed)
								lastspeed = DataValues[SPEED].fVal;
						} // else
					} // if
					
					// set max value
					if (DU2_AUTOX_COMPLETE != unsavedSysData.systemMode && DU2_DRAG_COMPLETE != unsavedSysData.systemMode) {
						if (DataValues[SPEED].fVal > DataValues[MAX_SPEED].fVal) {
							DataValues[MAX_SPEED].fVal = DataValues[SPEED].fVal;
							if (DataValues[SPEED].fVal > sysData.maxSpeedEver)
								sysData.maxSpeedEver = DataValues[SPEED].fVal;
						} // if
					} // if
				
					// use temp to preserve sign
					temp = SWAP16(tqmsample.secsamp.gps.alt);
					DataValues[ALTITUDE].fVal = (float) temp;

					if (DataValues[ALTITUDE].fVal > DataValues[MAX_ALTITUDE].fVal)
						DataValues[MAX_ALTITUDE].fVal = DataValues[ALTITUDE].fVal;

					if ((0.0 == DataValues[MIN_ALTITUDE].fVal) || (DataValues[ALTITUDE].fVal < DataValues[MIN_ALTITUDE].fVal))
						DataValues[MIN_ALTITUDE].fVal = DataValues[ALTITUDE].fVal;

					// relinquish global data
					OS_Unuse(&SEMA_GlobalData);
										
					// swap all the bytes around for windows
					tqmsample.secsamp.gps.time = SWAP32(tqmsample.secsamp.gps.time);
					tqmsample.secsamp.gps.weeks = SWAP16(tqmsample.secsamp.gps.weeks);
					tqmsample.secsamp.gps.lat = SWAP32(tqmsample.secsamp.gps.lat);
					tqmsample.secsamp.gps.lon = SWAP32(tqmsample.secsamp.gps.lon);
					tqmsample.secsamp.gps.alt = SWAP16(tqmsample.secsamp.gps.alt);

				} // if
				break;
			} // GPS_DATA
			case GPS_PULSE: {
				u16 dop = 0;

				retval = SendACK(msgptr[SOURCE]);

				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;

				// record the dillution of precision number
				dop = ((u16) msgptr[DATA_START+1] << 8) + (u16) (msgptr[DATA_START+2] & 0x00FF);

				if ((CAMERA_NONE != vehicleData.camera) || (CAMERA_USB != vehicleData.camera)) {
					// first byte has camera status
					pdrlancstatus = (pdrlancstatustype) (msgptr[DATA_START+3]);
					
					switch (pdrlancstatus) {
						case PDROFF:
						case PDRLANCNOTREADY:
						case PDRLANC2WIRE:
							DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_NOT_READY;
							break;					
						case PDRLANCREADY:
							DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_READY;
							break;
						case PDRLANCRECORD:
							DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_RECORDING;
							break;
						case UNKNOWN:
						case PDRLANCNOTCONNECTED:
						default:
							DataValues[CAMERA_STATUS].iVal = CAMERA_STATUS_NOT_CONNECTED;
					} // switch
				} // if
				
				// don't save any data until we see a GPS pulse so we can
				// synchronize position and io data with accelerometer data
				if (firstpulse) {
					firstpulse = false;
				}
				// only do this if we are storing data
				else if (DU2_RECORDING(unsavedSysData.systemMode)) {
					int size;
					
					// fill in any unprogrammed accel samples with previous values
					for (; gcnt < SAMP10S_PER_PAGE; gcnt++) {
						if (gcnt == 0) {
							tqmsample.secsamp.accel[gcnt][0] =
								((scratchpad.calibrate.xzero & 0x0F00) >> 4) +
								((scratchpad.calibrate.yzero & 0x0F00) >> 8);
							tqmsample.secsamp.accel[gcnt][1] =
								scratchpad.calibrate.xzero & 0xFF;
							tqmsample.secsamp.accel[gcnt][2] =
								scratchpad.calibrate.yzero & 0xFF;
						} // if
						else {
							tqmsample.secsamp.accel[gcnt][0] =
								tqmsample.secsamp.accel[gcnt-1][0];
							tqmsample.secsamp.accel[gcnt][1] =
								tqmsample.secsamp.accel[gcnt-1][1];
							tqmsample.secsamp.accel[gcnt][2] =
								tqmsample.secsamp.accel[gcnt-1][2];
						} // else
					} // for

					size = sizeof(samptype10) + (10*iobytesenabled);		// ten samples
					// variable length save depending on number of io points enabled
		
					if (0 != tqmWrite (&tqmsample, size)) {
#ifdef BUILD_DEBUG_PORT
						DBGU_Print("Session file error -- QUEUE FULL\n\r");
#endif
					} // if
				} // else

				gcnt = 0;		// either way, start a new second for G data
				iocnt = 0;

				// request use of global data
				OS_Use(&SEMA_GlobalData);
			
				// update global data
				DataValues[GPS_DOP].fVal = ((float) dop) / 100.0F;
				if (DataValues[GPS_DOP].fVal < DataValues[MIN_DOP].fVal)
					DataValues[MIN_DOP].fVal = DataValues[GPS_DOP].fVal;

				if (DataValues[GPS_DOP].fVal > DataValues[MAX_DOP].fVal)
					DataValues[MAX_DOP].fVal = DataValues[GPS_DOP].fVal;

				// relinquish global data
				OS_Unuse(&SEMA_GlobalData);				

				notifyGPS();			// tell lap timer that we have a new gps position
				
				break;
			} // GPS_PULSE
			case ACCEL_DATA: {
				int checkbits;			// used to check off the enable bits for data i/o
				u16 tempxy;
				u16 period = 0;
				float xg, yg;

				retval = SendACK(msgptr[SOURCE]);
			
				// free up unit for more communications
				COMMCTS[msgptr[SOURCE]-1] = 0;

				// put accel data into buffer
				tqmsample.secsamp.accel[gcnt][0] = msgptr[DATA_START];
				tqmsample.secsamp.accel[gcnt][1] = msgptr[DATA_START+1];
				tqmsample.secsamp.accel[gcnt][2] = msgptr[DATA_START+2];

				// scale the Y Gs
				tempxy = (tqmsample.secsamp.accel[gcnt][0] & 0x0F) << 8;
				tempxy += tqmsample.secsamp.accel[gcnt][2];
				yg = (float) accely.zero - tempxy;
				if (yg < 0.0) {
					yg = yg / (accely.zero - accely.min);
				} // if
				else  {
					yg = yg / (accely.max - accely.zero);
				} // else

				// scale the X Gs
				tempxy = (tqmsample.secsamp.accel[gcnt][0] & 0xF0) << 4;
				tempxy += tqmsample.secsamp.accel[gcnt][1];
				xg = (float) tempxy - accelx.zero;

				if (xg < 0.0) {
					xg = xg / (accelx.zero - accelx.min);
				} // if
				else {
					xg = xg / (accelx.max - accelx.zero);
				} // else
				
				// request use of global data
				OS_Use(&SEMA_GlobalData);
			
				// update indices for rolling filter history				
				grollingidx = (1+grollingidx) % G_FILTER_VAL;
				
				// update global data
				DataValues[X_G].fVal = xgrolling[grollingidx] = xg;
				DataValues[Y_G].fVal = ygrolling[grollingidx] = yg;
				
				// update the filtered G values
				xg = yg = 0.0;
				for (tempxy = 0; tempxy < G_FILTER_VAL; tempxy++) {
				  	xg += xgrolling[tempxy];
					yg += ygrolling[tempxy];
				} // for
				
				DataValues[X_G_DAMPED].fVal = xg / (float) G_FILTER_VAL;
				DataValues[Y_G_DAMPED].fVal = yg / (float) G_FILTER_VAL;
				
				// set max and min values using filtered values
				if (DataValues[X_G_DAMPED].fVal > DataValues[MAX_X_G].fVal)
					DataValues[MAX_X_G].fVal = DataValues[X_G_DAMPED].fVal;
				if (DataValues[X_G_DAMPED].fVal < DataValues[MIN_X_G].fVal)
					DataValues[MIN_X_G].fVal = DataValues[X_G_DAMPED].fVal;
				
				if (DataValues[Y_G_DAMPED].fVal > DataValues[MAX_Y_G].fVal)
						DataValues[MAX_Y_G].fVal = DataValues[Y_G_DAMPED].fVal;
				if (DataValues[Y_G_DAMPED].fVal < DataValues[MIN_Y_G].fVal)
					DataValues[MIN_Y_G].fVal = DataValues[Y_G_DAMPED].fVal;
				
				DataValues[COMBINED_G].fVal = sqrt(DataValues[X_G_DAMPED].fVal * DataValues[X_G_DAMPED].fVal + DataValues[Y_G_DAMPED].fVal * DataValues[Y_G_DAMPED].fVal);
				
				// relinquish global data
				OS_Unuse(&SEMA_GlobalData);

				// check if Data Interface attached - digital byte inverted at this point
				suData.traqDataConnected = (~msgptr[DATA_START+3] & TACHORDATA);

				// scan the i/o points in the order they arrive, MSB - LSB, DIA3A2A1A0F1F0
				for (checkbits = 6; checkbits >= 0; checkbits--) {
					// check for bit set enabling i/o point
					if ((iocollect >> checkbits) & 0x01) {
						
						// if we are recording save the io point byte
						if (DU2_RECORDING(unsavedSysData.systemMode)) {
							if (suData.traqDataConnected)
								tqmsample.IoData[iocnt] = msgptr[DATA_START+9-checkbits];
							else
								tqmsample.IoData[iocnt] = 0;
							if (iocnt < (10*iobytesenabled)-1)
								iocnt++;		// increment array index
						} // if

						switch (checkbits) {						
							case 6:
								DataValues[DIGITAL_INPUT_4].iVal = (msgptr[DATA_START+9-checkbits] & 0x10)? 1:0;
								DataValues[DIGITAL_INPUT_5].iVal = (msgptr[DATA_START+9-checkbits] & 0x20)? 1:0;
								break;
							case 5:
							case 4:
							case 3:
							case 2: {
								float tempfloat;
								
								if (vehicleData.analogInput[checkbits - 2].enabled) {

									// get the unfiltered value and scale it across its range
									tempfloat = (float) vehicleData.analogInput[checkbits - 2].inputRange *
										(float) msgptr[DATA_START+9-checkbits] / (float) VOLTFULLSCALE;

									// filter
									if (analogsinitialized && (vehicleData.analogInput[checkbits - 2].enabled > 1)) {
										// apply filtering: ((current value) * (filter level - 1) + new value) / (filter level)
										DataValues[ANALOG_INPUT_0 + (checkbits - 2)].fVal = (tempfloat +
											(DataValues[ANALOG_INPUT_0 + (checkbits - 2)].fVal * (float) (vehicleData.analogInput[checkbits - 2].enabled - 1))) /
											(float) vehicleData.analogInput[checkbits - 2].enabled;
									} // if
									else {		// first value so treat it differently
										DataValues[ANALOG_INPUT_0 + (checkbits - 2)].fVal = tempfloat;		// assign first value
									} // if

									// set max and min values in VOLTS
									if (DataValues[ANALOG_INPUT_0 + (checkbits - 2)].fVal > DataValues[MAX_A_0 + (checkbits - 2)].fVal)
										DataValues[MAX_A_0 + (checkbits - 2)].fVal = DataValues[ANALOG_INPUT_0 + (checkbits - 2)].fVal;
									
									if (DataValues[ANALOG_INPUT_0 + (checkbits - 2)].fVal < DataValues[MIN_A_0 + (checkbits - 2)].fVal)
										DataValues[MIN_A_0 + (checkbits - 2)].fVal = DataValues[ANALOG_INPUT_0 + (checkbits - 2)].fVal;
								
								} // if
								break;
							} // case
							case 1:		// MSB
								period = (msgptr[DATA_START+9-checkbits]) << 8;
								break;
							case 0:		// LSB
								period += msgptr[DATA_START+9-checkbits];
								break;
						} // switch
					} // if
				} // for
				
				// completed at least one time through
				analogsinitialized = TRUE;

				// request use of global data
				OS_Use(&SEMA_GlobalData);
				
				// process the rpm
				if (period == 0)
					DataValues[VEHICLE_RPM].iVal = 0;
				else {
					float tempfloat;

					// figure out rpm in hz
					tempfloat = (float) FREQ_SAMPLE_RATE / (float) period;
			
					// rpm
					if (0 == vehicleData.engineCylinders) // kart
						DataValues[VEHICLE_RPM].iVal = (u16) (tempfloat * 60.0 * 4.0);
					else {
						tempfloat = tempfloat * 60.0 * 2.0 / (float) vehicleData.engineCylinders;
						DataValues[VEHICLE_RPM].uVal = (u16) tempfloat;
					} // else

					// count highrevs and overrevs
					if (DataValues[VEHICLE_RPM].uVal > vehicleData.tach.lowerRedStart) {	// high rev
						if (!inhighrev) {
							inhighrev = true;
							DataValues[TOTAL_HIGHREVS].uVal++;
						} // if
					} // if
					else {		// not in high rev
						inhighrev = false;
					} // else

					if (DataValues[VEHICLE_RPM].uVal > vehicleData.tach.scaleEnd) {	// overrev
						if (!inoverrev) {
							inoverrev = true;
							DataValues[TOTAL_OVERREVS].uVal++;
						} // if
					} // if
					else {		// not in high rev
						inoverrev = false;
					} // else
						
					// set max values
					if (DataValues[VEHICLE_RPM].uVal > DataValues[MAX_RPM].uVal) {
						DataValues[MAX_RPM].uVal = DataValues[VEHICLE_RPM].uVal;
						if (DataValues[VEHICLE_RPM].uVal > sysData.maxRpmEver)
							sysData.maxRpmEver = DataValues[VEHICLE_RPM].uVal;
					} // if
				} // else
				
				// relinquish global data
				OS_Unuse(&SEMA_GlobalData);

				SetGear( GEAR_CALC );		// calculate the gear we are in
				SetWarningLED(BOTH_WARNING_LED, (int) GetValue(ANALOG_INPUT_0).fVal);
				SetTachLEDs(GetValue(VEHICLE_RPM).iVal);
				
				if (gcnt < 9)
					gcnt++;		// increment array index
				break;
			} // ACCEL_DATA

			default:
				// grab the port
				COMMCTS[msgptr[SOURCE]-1] = CTS_COUNTDOWN;

				// say what?
				retval = SendNAK(msgptr[SOURCE], UNKNOWN_FUNCTION);
				retval = -1; // no valid opcode found - normally send NAK
				break;		
			} // switch
		} // else
	} // else

	return(retval);  // this should be the return value of sending ACK or ACK with
	                 // data, assuming the opcode processes successfully
}

// The following function calculates the crc16 result and verifies it against*/
// the received value in the data.  The function returns:
// 0 if the crc compares
// -1 if the crc does not match

s16 Verify_CRC(u08 * dat, u16 bytecount) {
	u16 retval, data_crc ;

	retval = crc16(dat, bytecount); // calculate the crc on the received data

	data_crc = (dat[bytecount])<<8 ;  // get the crc from the message
	data_crc += (dat[bytecount+1]);

	if (retval == data_crc) // check calculated against received
		return((s16) 0) ;  // if the crc's match
	else
		return((s16) -1); // -1 otherwise
}

s16 SendNAK(u08 dest,		// unit id of destination
			u08 reason) {
	com[msgrouting[dest]].txbuff[DATA_START] = reason ;
	SendMessage(msgrouting[0], dest,NAK,1);

	return((s16) 0) ;

}
