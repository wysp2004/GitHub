﻿; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.40219.01 

	TITLE	C:\DUII\DUII\PredictiveLapTimer.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

CONST	SEGMENT
$SG10214 DB	'%+.1f', 00H
	ORG $+2
$SG10216 DB	'%+.2f', 00H
	ORG $+2
$SG10245 DB	'%+.2f', 00H
CONST	ENDS
PUBLIC	?CreateBackground@PredictiveLapTimer@@AAEXXZ	; PredictiveLapTimer::CreateBackground
PUBLIC	??0PredictiveLapTimer@@QAE@HHHHMMJ@Z		; PredictiveLapTimer::PredictiveLapTimer
EXTRN	_GUI_MEMDEV_Create:PROC
EXTRN	_SystemError:PROC
EXTRN	_WM_CreateWindowAsChild:PROC
EXTRN	__fltused:DWORD
EXTRN	__RTC_CheckEsp:PROC
EXTRN	__RTC_Shutdown:PROC
EXTRN	__RTC_InitBase:PROC
;	COMDAT rtc$TMZ
; File c:\duii\duii\predictivelaptimer.cpp
rtc$TMZ	SEGMENT
__RTC_Shutdown.rtc$TMZ DD FLAT:__RTC_Shutdown
rtc$TMZ	ENDS
;	COMDAT rtc$IMZ
rtc$IMZ	SEGMENT
__RTC_InitBase.rtc$IMZ DD FLAT:__RTC_InitBase
; Function compile flags: /Odtp /RTCsu /ZI
rtc$IMZ	ENDS
;	COMDAT ??0PredictiveLapTimer@@QAE@HHHHMMJ@Z
_TEXT	SEGMENT
tv65 = -208						; size = 4
_this$ = -8						; size = 4
_x$ = 8							; size = 4
_y$ = 12						; size = 4
_xsize$ = 16						; size = 4
_ysize$ = 20						; size = 4
_fMax$ = 24						; size = 4
_fMin$ = 28						; size = 4
__hParent$ = 32						; size = 4
??0PredictiveLapTimer@@QAE@HHHHMMJ@Z PROC		; PredictiveLapTimer::PredictiveLapTimer, COMDAT
; _this$ = ecx
; Line 6
	push	ebp
	mov	ebp, esp
	sub	esp, 208				; 000000d0H
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-208]
	mov	ecx, 52					; 00000034H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
; Line 7
	push	0
	push	0
	push	0
	mov	eax, DWORD PTR __hParent$[ebp]
	push	eax
	mov	ecx, DWORD PTR _ysize$[ebp]
	push	ecx
	mov	edx, DWORD PTR _xsize$[ebp]
	push	edx
	mov	eax, DWORD PTR _y$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x$[ebp]
	push	ecx
	call	_WM_CreateWindowAsChild
	add	esp, 32					; 00000020H
	mov	DWORD PTR tv65[ebp], eax
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR tv65[ebp]
	mov	DWORD PTR [edx+40], eax
	cmp	DWORD PTR tv65[ebp], 0
	jg	SHORT $LN1@Predictive
; Line 8
	call	_SystemError
$LN1@Predictive:
; Line 10
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _x$[ebp]
	mov	DWORD PTR [eax], ecx
; Line 11
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _y$[ebp]
	mov	DWORD PTR [eax+4], ecx
; Line 12
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _xsize$[ebp]
	mov	DWORD PTR [eax+8], ecx
; Line 13
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _ysize$[ebp]
	mov	DWORD PTR [eax+12], ecx
; Line 15
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR _fMax$[ebp]
	fstp	DWORD PTR [eax+32]
; Line 16
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR _fMin$[ebp]
	fstp	DWORD PTR [eax+36]
; Line 18
	mov	eax, DWORD PTR _this$[ebp]
	mov	DWORD PTR [eax+44], 0
; Line 20
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+12]
	push	ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+8]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	push	ecx
	call	_GUI_MEMDEV_Create
	add	esp, 16					; 00000010H
	mov	edx, DWORD PTR _this$[ebp]
	mov	DWORD PTR [edx+48], eax
; Line 22
	mov	eax, DWORD PTR _this$[ebp]
	fild	DWORD PTR [eax+8]
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR _this$[ebp]
	fld	DWORD PTR [ecx+32]
	fsub	DWORD PTR [edx+36]
	fdivp	ST(1), ST(0)
	mov	eax, DWORD PTR _this$[ebp]
	fstp	DWORD PTR [eax+24]
; Line 24
	mov	ecx, DWORD PTR _this$[ebp]
	call	?CreateBackground@PredictiveLapTimer@@AAEXXZ ; PredictiveLapTimer::CreateBackground
; Line 25
	mov	eax, DWORD PTR _this$[ebp]
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 208				; 000000d0H
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	28					; 0000001cH
??0PredictiveLapTimer@@QAE@HHHHMMJ@Z ENDP		; PredictiveLapTimer::PredictiveLapTimer
_TEXT	ENDS
PUBLIC	??1PredictiveLapTimer@@QAE@XZ			; PredictiveLapTimer::~PredictiveLapTimer
EXTRN	_GUI_MEMDEV_Delete:PROC
; Function compile flags: /Odtp /RTCsu /ZI
;	COMDAT ??1PredictiveLapTimer@@QAE@XZ
_TEXT	SEGMENT
_this$ = -8						; size = 4
??1PredictiveLapTimer@@QAE@XZ PROC			; PredictiveLapTimer::~PredictiveLapTimer, COMDAT
; _this$ = ecx
; Line 28
	push	ebp
	mov	ebp, esp
	sub	esp, 204				; 000000ccH
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-204]
	mov	ecx, 51					; 00000033H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
; Line 29
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+48]
	push	ecx
	call	_GUI_MEMDEV_Delete
	add	esp, 4
; Line 30
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+44]
	push	ecx
	call	_GUI_MEMDEV_Delete
	add	esp, 4
; Line 31
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 204				; 000000ccH
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
??1PredictiveLapTimer@@QAE@XZ ENDP			; PredictiveLapTimer::~PredictiveLapTimer
_TEXT	ENDS
EXTRN	_GUI_SelectLCD:PROC
EXTRN	_GUI_DrawLine:PROC
EXTRN	_GUI_SetColor:PROC
EXTRN	_GUI_SetPenSize:PROC
EXTRN	_GUI_SetTextMode:PROC
EXTRN	_GUI_MEMDEV_Select:PROC
; Function compile flags: /Odtp /RTCsu /ZI
;	COMDAT ?CreateBackground@PredictiveLapTimer@@AAEXXZ
_TEXT	SEGMENT
_iTemp$ = -80						; size = 4
_i$ = -68						; size = 4
_y2$ = -56						; size = 4
_x2$ = -44						; size = 4
_y1$ = -32						; size = 4
_x1$ = -20						; size = 4
_this$ = -8						; size = 4
?CreateBackground@PredictiveLapTimer@@AAEXXZ PROC	; PredictiveLapTimer::CreateBackground, COMDAT
; _this$ = ecx
; Line 34
	push	ebp
	mov	ebp, esp
	sub	esp, 276				; 00000114H
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-276]
	mov	ecx, 69					; 00000045H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
; Line 38
	mov	eax, DWORD PTR _this$[ebp]
	cmp	DWORD PTR [eax+44], 0
	je	SHORT $LN4@CreateBack
; Line 39
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+44]
	push	ecx
	call	_GUI_MEMDEV_Delete
	add	esp, 4
$LN4@CreateBack:
; Line 41
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+12]
	push	ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+8]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	push	ecx
	call	_GUI_MEMDEV_Create
	add	esp, 16					; 00000010H
	mov	edx, DWORD PTR _this$[ebp]
	mov	DWORD PTR [edx+44], eax
; Line 42
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+44]
	push	ecx
	call	_GUI_MEMDEV_Select
	add	esp, 4
; Line 44
	push	2
	call	_GUI_SetTextMode
	add	esp, 4
; Line 46
	push	3
	call	_GUI_SetPenSize
	add	esp, 4
; Line 47
	push	16777215				; 00ffffffH
	call	_GUI_SetColor
	add	esp, 4
; Line 49
	mov	eax, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [eax+8]
	cdq
	sub	eax, edx
	sar	eax, 1
	mov	ecx, DWORD PTR _this$[ebp]
	add	eax, DWORD PTR [ecx]
	mov	edx, DWORD PTR _this$[ebp]
	mov	DWORD PTR [edx+16], eax
; Line 52
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _x1$[ebp], ecx
; Line 53
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _y1$[ebp], ecx
; Line 54
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+8]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _x2$[ebp], ecx
; Line 55
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+12]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _y2$[ebp], ecx
; Line 57
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _x1$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 58
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _x2$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 59
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y2$[ebp]
	push	edx
	mov	eax, DWORD PTR _x2$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 60
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y2$[ebp]
	push	edx
	mov	eax, DWORD PTR _x1$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 63
	mov	eax, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [eax+8]
	cdq
	and	edx, 3
	add	eax, edx
	sar	eax, 2
	mov	DWORD PTR _iTemp$[ebp], eax
; Line 66
	mov	DWORD PTR _i$[ebp], 1
	jmp	SHORT $LN3@CreateBack
$LN2@CreateBack:
	mov	eax, DWORD PTR _i$[ebp]
	add	eax, 1
	mov	DWORD PTR _i$[ebp], eax
$LN3@CreateBack:
	cmp	DWORD PTR _i$[ebp], 4
	jge	SHORT $LN1@CreateBack
; Line 68
	mov	eax, DWORD PTR _i$[ebp]
	imul	eax, DWORD PTR _iTemp$[ebp]
	mov	ecx, DWORD PTR _this$[ebp]
	add	eax, DWORD PTR [ecx]
	mov	DWORD PTR _x1$[ebp], eax
; Line 77
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _x1$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 78
	jmp	SHORT $LN2@CreateBack
$LN1@CreateBack:
; Line 83
	call	_GUI_SelectLCD
; Line 84
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 276				; 00000114H
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
?CreateBackground@PredictiveLapTimer@@AAEXXZ ENDP	; PredictiveLapTimer::CreateBackground
_TEXT	ENDS
PUBLIC	__real@c024000000000000
PUBLIC	__real@4024000000000000
PUBLIC	__real@00000000
PUBLIC	?GetRect@PredictiveLapTimer@@QAEXPAULCD_RECT@@@Z ; PredictiveLapTimer::GetRect
PUBLIC	__$ArrayPad$
PUBLIC	?DrawControl@PredictiveLapTimer@@QAEXXZ		; PredictiveLapTimer::DrawControl
EXTRN	_GUI_DispStringAt:PROC
EXTRN	_GUI_GetFontDistY:PROC
EXTRN	_sprintf:PROC
EXTRN	_GUI_MEMDEV_Write:PROC
EXTRN	_GUI_DrawGradientV:PROC
EXTRN	_GUI_ClearRect:PROC
EXTRN	_GUI_DispStringInRect:PROC
EXTRN	_GUI_Font32B_ASCII:BYTE
EXTRN	_GUI_SetFont:PROC
EXTRN	_GUI_Font20_ASCII:BYTE
EXTRN	_strlen:PROC
EXTRN	___security_cookie:DWORD
EXTRN	@__security_check_cookie@4:PROC
EXTRN	@_RTC_CheckStackVars@8:PROC
EXTRN	__ftol2_sse:PROC
;	COMDAT __real@c024000000000000
CONST	SEGMENT
__real@c024000000000000 DQ 0c024000000000000r	; -10
CONST	ENDS
;	COMDAT __real@4024000000000000
CONST	SEGMENT
__real@4024000000000000 DQ 04024000000000000r	; 10
CONST	ENDS
;	COMDAT __real@00000000
CONST	SEGMENT
__real@00000000 DD 000000000r			; 0
; Function compile flags: /Odtp /RTCsu /ZI
CONST	ENDS
;	COMDAT ?DrawControl@PredictiveLapTimer@@QAEXXZ
_TEXT	SEGMENT
_rect$10202 = -108					; size = 8
_str$ = -92						; size = 10
_iTemp$ = -72						; size = 4
_y2$ = -60						; size = 4
_x2$ = -48						; size = 4
_y1$ = -36						; size = 4
_x1$ = -24						; size = 4
_this$ = -12						; size = 4
__$ArrayPad$ = -4					; size = 4
?DrawControl@PredictiveLapTimer@@QAEXXZ PROC		; PredictiveLapTimer::DrawControl, COMDAT
; _this$ = ecx
; Line 90
	push	ebp
	mov	ebp, esp
	sub	esp, 304				; 00000130H
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-304]
	mov	ecx, 76					; 0000004cH
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	eax, DWORD PTR ___security_cookie
	xor	eax, ebp
	mov	DWORD PTR __$ArrayPad$[ebp], eax
	mov	DWORD PTR _this$[ebp], ecx
; Line 94
	mov	eax, DWORD PTR _this$[ebp]
	cmp	DWORD PTR [eax+28], 0
	je	$LN13@DrawContro
; Line 99
	push	2
	call	_GUI_SetPenSize
	add	esp, 4
; Line 100
	push	16777215				; 00ffffffH
	call	_GUI_SetColor
	add	esp, 4
; Line 101
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _x1$[ebp], ecx
; Line 102
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _y1$[ebp], ecx
; Line 103
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+8]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _x2$[ebp], ecx
; Line 104
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+12]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _y2$[ebp], ecx
; Line 106
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _x1$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 107
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _x2$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 108
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y2$[ebp]
	push	edx
	mov	eax, DWORD PTR _x2$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 109
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y2$[ebp]
	push	edx
	mov	eax, DWORD PTR _x1$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 112
	lea	eax, DWORD PTR _rect$10202[ebp]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	call	?GetRect@PredictiveLapTimer@@QAEXPAULCD_RECT@@@Z ; PredictiveLapTimer::GetRect
; Line 114
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+28]
	push	ecx
	call	_strlen
	add	esp, 4
	cmp	eax, 15					; 0000000fH
	jbe	SHORT $LN12@DrawContro
	mov	eax, DWORD PTR _this$[ebp]
	cmp	DWORD PTR [eax+8], 300			; 0000012cH
	jge	SHORT $LN12@DrawContro
; Line 115
	push	OFFSET _GUI_Font20_ASCII
	call	_GUI_SetFont
	add	esp, 4
	jmp	SHORT $LN11@DrawContro
$LN12@DrawContro:
; Line 116
	push	OFFSET _GUI_Font32B_ASCII
	call	_GUI_SetFont
	add	esp, 4
$LN11@DrawContro:
; Line 118
	push	14					; 0000000eH
	lea	eax, DWORD PTR _rect$10202[ebp]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+28]
	push	edx
	call	_GUI_DispStringInRect
	add	esp, 12					; 0000000cH
; Line 120
	jmp	$LN10@DrawContro
$LN13@DrawContro:
; Line 122
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+12]
	push	ecx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+8]
	push	ecx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	push	ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx]
	push	eax
	call	_GUI_ClearRect
	add	esp, 16					; 00000010H
; Line 124
	mov	eax, DWORD PTR _this$[ebp]
	fldz
	fcomp	DWORD PTR [eax+20]
	fnstsw	ax
	test	ah, 65					; 00000041H
	jp	SHORT $LN9@DrawContro
; Line 127
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _x1$[ebp], ecx
; Line 128
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	fmul	DWORD PTR [ecx+24]
	call	__ftol2_sse
	mov	edx, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [edx+16]
	sub	ecx, eax
	mov	DWORD PTR _x2$[ebp], ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR _x2$[ebp]
	cmp	eax, DWORD PTR [edx]
	jge	SHORT $LN8@DrawContro
; Line 129
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _x2$[ebp], ecx
$LN8@DrawContro:
; Line 130
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	add	ecx, 4
	mov	DWORD PTR _y1$[ebp], ecx
; Line 131
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+12]
	lea	ecx, DWORD PTR [ecx+eax-1]
	mov	DWORD PTR _y2$[ebp], ecx
; Line 132
	push	0
	push	255					; 000000ffH
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+16]
	push	edx
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	call	_GUI_DrawGradientV
	add	esp, 24					; 00000018H
; Line 134
	jmp	$LN7@DrawContro
$LN9@DrawContro:
; Line 137
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	fmul	DWORD PTR [ecx+24]
	call	__ftol2_sse
	mov	edx, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [edx+16]
	sub	ecx, eax
	mov	DWORD PTR _x1$[ebp], ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx]
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+8]
	lea	eax, DWORD PTR [eax+edx-3]
	cmp	DWORD PTR _x1$[ebp], eax
	jle	SHORT $LN6@DrawContro
; Line 138
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+8]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _x1$[ebp], ecx
$LN6@DrawContro:
; Line 139
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+8]
	mov	DWORD PTR _x2$[ebp], ecx
; Line 140
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	add	ecx, 4
	mov	DWORD PTR _y1$[ebp], ecx
; Line 141
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+12]
	lea	ecx, DWORD PTR [ecx+eax-1]
	mov	DWORD PTR _y2$[ebp], ecx
; Line 142
	push	0
	push	65280					; 0000ff00H
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+16]
	push	ecx
	call	_GUI_DrawGradientV
	add	esp, 24					; 00000018H
$LN7@DrawContro:
; Line 145
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+44]
	push	ecx
	call	_GUI_MEMDEV_Write
	add	esp, 4
; Line 147
	push	OFFSET _GUI_Font32B_ASCII
	call	_GUI_SetFont
	add	esp, 4
; Line 148
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	fcomp	QWORD PTR __real@4024000000000000
	fnstsw	ax
	test	ah, 1
	je	SHORT $LN4@DrawContro
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	fcomp	QWORD PTR __real@c024000000000000
	fnstsw	ax
	test	ah, 65					; 00000041H
	jp	SHORT $LN5@DrawContro
$LN4@DrawContro:
; Line 149
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	sub	esp, 8
	fstp	QWORD PTR [esp]
	push	OFFSET $SG10214
	lea	ecx, DWORD PTR _str$[ebp]
	push	ecx
	call	_sprintf
	add	esp, 16					; 00000010H
; Line 150
	jmp	SHORT $LN3@DrawContro
$LN5@DrawContro:
; Line 151
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	sub	esp, 8
	fstp	QWORD PTR [esp]
	push	OFFSET $SG10216
	lea	ecx, DWORD PTR _str$[ebp]
	push	ecx
	call	_sprintf
	add	esp, 16					; 00000010H
$LN3@DrawContro:
; Line 152
	call	_GUI_GetFontDistY
	mov	DWORD PTR _iTemp$[ebp], eax
; Line 153
	mov	eax, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [eax+12]
	cdq
	sub	eax, edx
	sar	eax, 1
	mov	ecx, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [ecx+4]
	add	ecx, eax
	mov	eax, DWORD PTR _iTemp$[ebp]
	cdq
	sub	eax, edx
	sar	eax, 1
	sub	ecx, eax
	mov	DWORD PTR _y1$[ebp], ecx
; Line 154
	mov	eax, DWORD PTR _this$[ebp]
	fldz
	fcomp	DWORD PTR [eax+20]
	fnstsw	ax
	test	ah, 65					; 00000041H
	jp	SHORT $LN2@DrawContro
; Line 156
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+16]
	add	ecx, 8
	mov	DWORD PTR _x1$[ebp], ecx
; Line 157
	push	255					; 000000ffH
	call	_GUI_SetColor
	add	esp, 4
; Line 159
	jmp	SHORT $LN1@DrawContro
$LN2@DrawContro:
; Line 161
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+16]
	sub	ecx, 72					; 00000048H
	mov	DWORD PTR _x1$[ebp], ecx
; Line 162
	push	65280					; 0000ff00H
	call	_GUI_SetColor
	add	esp, 4
$LN1@DrawContro:
; Line 164
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	lea	edx, DWORD PTR _str$[ebp]
	push	edx
	call	_GUI_DispStringAt
	add	esp, 12					; 0000000cH
$LN10@DrawContro:
; Line 166
	push	edx
	mov	ecx, ebp
	push	eax
	lea	edx, DWORD PTR $LN19@DrawContro
	call	@_RTC_CheckStackVars@8
	pop	eax
	pop	edx
	pop	edi
	pop	esi
	pop	ebx
	mov	ecx, DWORD PTR __$ArrayPad$[ebp]
	xor	ecx, ebp
	call	@__security_check_cookie@4
	add	esp, 304				; 00000130H
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
	npad	1
$LN19@DrawContro:
	DD	2
	DD	$LN18@DrawContro
$LN18@DrawContro:
	DD	-92					; ffffffa4H
	DD	10					; 0000000aH
	DD	$LN16@DrawContro
	DD	-108					; ffffff94H
	DD	8
	DD	$LN17@DrawContro
$LN17@DrawContro:
	DB	114					; 00000072H
	DB	101					; 00000065H
	DB	99					; 00000063H
	DB	116					; 00000074H
	DB	0
$LN16@DrawContro:
	DB	115					; 00000073H
	DB	116					; 00000074H
	DB	114					; 00000072H
	DB	0
?DrawControl@PredictiveLapTimer@@QAEXXZ ENDP		; PredictiveLapTimer::DrawControl
; Function compile flags: /Odtp /RTCsu /ZI
_TEXT	ENDS
;	COMDAT ?GetRect@PredictiveLapTimer@@QAEXPAULCD_RECT@@@Z
_TEXT	SEGMENT
_this$ = -8						; size = 4
_rect$ = 8						; size = 4
?GetRect@PredictiveLapTimer@@QAEXPAULCD_RECT@@@Z PROC	; PredictiveLapTimer::GetRect, COMDAT
; _this$ = ecx
; File c:\duii\duii\predictivelaptimer.hpp
; Line 22
	push	ebp
	mov	ebp, esp
	sub	esp, 204				; 000000ccH
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-204]
	mov	ecx, 51					; 00000033H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
; Line 23
	mov	eax, DWORD PTR _rect$[ebp]
	mov	ecx, DWORD PTR _this$[ebp]
	mov	dx, WORD PTR [ecx]
	mov	WORD PTR [eax], dx
; Line 24
	mov	eax, DWORD PTR _rect$[ebp]
	mov	ecx, DWORD PTR _this$[ebp]
	mov	dx, WORD PTR [ecx+4]
	mov	WORD PTR [eax+2], dx
; Line 25
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+8]
	mov	eax, DWORD PTR _rect$[ebp]
	mov	WORD PTR [eax+4], cx
; Line 26
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+12]
	mov	eax, DWORD PTR _rect$[ebp]
	mov	WORD PTR [eax+6], cx
; Line 27
	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	4
?GetRect@PredictiveLapTimer@@QAEXPAULCD_RECT@@@Z ENDP	; PredictiveLapTimer::GetRect
_TEXT	ENDS
PUBLIC	?SetValue@PredictiveLapTimer@@QAEXM@Z		; PredictiveLapTimer::SetValue
; Function compile flags: /Odtp /RTCsu /ZI
;	COMDAT ?SetValue@PredictiveLapTimer@@QAEXM@Z
_TEXT	SEGMENT
_this$ = -8						; size = 4
_dValue$ = 8						; size = 4
?SetValue@PredictiveLapTimer@@QAEXM@Z PROC		; PredictiveLapTimer::SetValue, COMDAT
; _this$ = ecx
; File c:\duii\duii\predictivelaptimer.cpp
; Line 169
	push	ebp
	mov	ebp, esp
	sub	esp, 204				; 000000ccH
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-204]
	mov	ecx, 51					; 00000033H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
; Line 170
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR _dValue$[ebp]
	fstp	DWORD PTR [eax+20]
; Line 171
	mov	eax, DWORD PTR _this$[ebp]
	mov	DWORD PTR [eax+28], 0
; Line 172
	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	4
?SetValue@PredictiveLapTimer@@QAEXM@Z ENDP		; PredictiveLapTimer::SetValue
_TEXT	ENDS
PUBLIC	?SetValue@PredictiveLapTimer@@QAEXPAD@Z		; PredictiveLapTimer::SetValue
; Function compile flags: /Odtp /RTCsu /ZI
;	COMDAT ?SetValue@PredictiveLapTimer@@QAEXPAD@Z
_TEXT	SEGMENT
_this$ = -8						; size = 4
_pText$ = 8						; size = 4
?SetValue@PredictiveLapTimer@@QAEXPAD@Z PROC		; PredictiveLapTimer::SetValue, COMDAT
; _this$ = ecx
; Line 175
	push	ebp
	mov	ebp, esp
	sub	esp, 204				; 000000ccH
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-204]
	mov	ecx, 51					; 00000033H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	DWORD PTR _this$[ebp], ecx
; Line 176
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _pText$[ebp]
	mov	DWORD PTR [eax+28], ecx
; Line 177
	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	4
?SetValue@PredictiveLapTimer@@QAEXPAD@Z ENDP		; PredictiveLapTimer::SetValue
_TEXT	ENDS
PUBLIC	__$ArrayPad$
PUBLIC	?DrawToMemArea@PredictiveLapTimer@@QAEJXZ	; PredictiveLapTimer::DrawToMemArea
; Function compile flags: /Odtp /RTCsu /ZI
;	COMDAT ?DrawToMemArea@PredictiveLapTimer@@QAEJXZ
_TEXT	SEGMENT
_rect$10237 = -108					; size = 8
_str$ = -92						; size = 10
_iTemp$ = -72						; size = 4
_y2$ = -60						; size = 4
_x2$ = -48						; size = 4
_y1$ = -36						; size = 4
_x1$ = -24						; size = 4
_this$ = -12						; size = 4
__$ArrayPad$ = -4					; size = 4
?DrawToMemArea@PredictiveLapTimer@@QAEJXZ PROC		; PredictiveLapTimer::DrawToMemArea, COMDAT
; _this$ = ecx
; Line 180
	push	ebp
	mov	ebp, esp
	sub	esp, 304				; 00000130H
	push	ebx
	push	esi
	push	edi
	push	ecx
	lea	edi, DWORD PTR [ebp-304]
	mov	ecx, 76					; 0000004cH
	mov	eax, -858993460				; ccccccccH
	rep stosd
	pop	ecx
	mov	eax, DWORD PTR ___security_cookie
	xor	eax, ebp
	mov	DWORD PTR __$ArrayPad$[ebp], eax
	mov	DWORD PTR _this$[ebp], ecx
; Line 184
	mov	eax, DWORD PTR _this$[ebp]
	cmp	DWORD PTR [eax+28], 0
	je	$LN8@DrawToMemA
; Line 189
	push	2
	call	_GUI_SetPenSize
	add	esp, 4
; Line 190
	push	16777215				; 00ffffffH
	call	_GUI_SetColor
	add	esp, 4
; Line 191
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _x1$[ebp], ecx
; Line 192
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _y1$[ebp], ecx
; Line 193
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+8]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _x2$[ebp], ecx
; Line 194
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+12]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _y2$[ebp], ecx
; Line 196
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _x1$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 197
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _x2$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 198
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y2$[ebp]
	push	edx
	mov	eax, DWORD PTR _x2$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 199
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y2$[ebp]
	push	edx
	mov	eax, DWORD PTR _x1$[ebp]
	push	eax
	call	_GUI_DrawLine
	add	esp, 16					; 00000010H
; Line 202
	lea	eax, DWORD PTR _rect$10237[ebp]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	call	?GetRect@PredictiveLapTimer@@QAEXPAULCD_RECT@@@Z ; PredictiveLapTimer::GetRect
; Line 203
	push	OFFSET _GUI_Font32B_ASCII
	call	_GUI_SetFont
	add	esp, 4
; Line 204
	push	14					; 0000000eH
	lea	eax, DWORD PTR _rect$10237[ebp]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+28]
	push	edx
	call	_GUI_DispStringInRect
	add	esp, 12					; 0000000cH
; Line 207
	xor	eax, eax
	jmp	$LN7@DrawToMemA
; Line 209
	jmp	$LN7@DrawToMemA
$LN8@DrawToMemA:
; Line 211
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+48]
	push	ecx
	call	_GUI_MEMDEV_Select
	add	esp, 4
; Line 213
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+12]
	push	ecx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+8]
	push	ecx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	push	ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx]
	push	eax
	call	_GUI_ClearRect
	add	esp, 16					; 00000010H
; Line 215
	mov	eax, DWORD PTR _this$[ebp]
	fldz
	fcomp	DWORD PTR [eax+20]
	fnstsw	ax
	test	ah, 65					; 00000041H
	jp	SHORT $LN6@DrawToMemA
; Line 218
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _x1$[ebp], ecx
; Line 219
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	fmul	DWORD PTR [ecx+24]
	call	__ftol2_sse
	mov	edx, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [edx+16]
	sub	ecx, eax
	mov	DWORD PTR _x2$[ebp], ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR _x2$[ebp]
	cmp	eax, DWORD PTR [edx]
	jge	SHORT $LN5@DrawToMemA
; Line 220
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR _x2$[ebp], ecx
$LN5@DrawToMemA:
; Line 221
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	add	ecx, 4
	mov	DWORD PTR _y1$[ebp], ecx
; Line 222
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+12]
	lea	ecx, DWORD PTR [ecx+eax-1]
	mov	DWORD PTR _y2$[ebp], ecx
; Line 223
	push	0
	push	255					; 000000ffH
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+16]
	push	edx
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x2$[ebp]
	push	ecx
	call	_GUI_DrawGradientV
	add	esp, 24					; 00000018H
; Line 225
	jmp	$LN4@DrawToMemA
$LN6@DrawToMemA:
; Line 228
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	fmul	DWORD PTR [ecx+24]
	call	__ftol2_sse
	mov	edx, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [edx+16]
	sub	ecx, eax
	mov	DWORD PTR _x1$[ebp], ecx
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx]
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR [ecx+8]
	lea	eax, DWORD PTR [eax+edx-3]
	cmp	DWORD PTR _x1$[ebp], eax
	jle	SHORT $LN3@DrawToMemA
; Line 229
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+8]
	lea	ecx, DWORD PTR [ecx+eax-3]
	mov	DWORD PTR _x1$[ebp], ecx
$LN3@DrawToMemA:
; Line 230
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, DWORD PTR _this$[ebp]
	add	ecx, DWORD PTR [edx+8]
	mov	DWORD PTR _x2$[ebp], ecx
; Line 231
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	add	ecx, 4
	mov	DWORD PTR _y1$[ebp], ecx
; Line 232
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [edx+12]
	lea	ecx, DWORD PTR [ecx+eax-1]
	mov	DWORD PTR _y2$[ebp], ecx
; Line 233
	push	0
	push	65280					; 0000ff00H
	mov	eax, DWORD PTR _y2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	mov	edx, DWORD PTR _y1$[ebp]
	push	edx
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+16]
	push	ecx
	call	_GUI_DrawGradientV
	add	esp, 24					; 00000018H
$LN4@DrawToMemA:
; Line 236
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+44]
	push	ecx
	call	_GUI_MEMDEV_Write
	add	esp, 4
; Line 238
	push	OFFSET _GUI_Font32B_ASCII
	call	_GUI_SetFont
	add	esp, 4
; Line 239
	mov	eax, DWORD PTR _this$[ebp]
	fld	DWORD PTR [eax+20]
	sub	esp, 8
	fstp	QWORD PTR [esp]
	push	OFFSET $SG10245
	lea	ecx, DWORD PTR _str$[ebp]
	push	ecx
	call	_sprintf
	add	esp, 16					; 00000010H
; Line 240
	call	_GUI_GetFontDistY
	mov	DWORD PTR _iTemp$[ebp], eax
; Line 241
	mov	eax, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [eax+12]
	cdq
	sub	eax, edx
	sar	eax, 1
	mov	ecx, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [ecx+4]
	add	ecx, eax
	mov	eax, DWORD PTR _iTemp$[ebp]
	cdq
	sub	eax, edx
	sar	eax, 1
	sub	ecx, eax
	mov	DWORD PTR _y1$[ebp], ecx
; Line 243
	mov	eax, DWORD PTR _this$[ebp]
	fldz
	fcomp	DWORD PTR [eax+20]
	fnstsw	ax
	test	ah, 65					; 00000041H
	jp	SHORT $LN2@DrawToMemA
; Line 245
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+16]
	add	ecx, 8
	mov	DWORD PTR _x1$[ebp], ecx
; Line 246
	push	255					; 000000ffH
	call	_GUI_SetColor
	add	esp, 4
; Line 248
	jmp	SHORT $LN1@DrawToMemA
$LN2@DrawToMemA:
; Line 250
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+16]
	sub	ecx, 72					; 00000048H
	mov	DWORD PTR _x1$[ebp], ecx
; Line 251
	push	65280					; 0000ff00H
	call	_GUI_SetColor
	add	esp, 4
$LN1@DrawToMemA:
; Line 253
	mov	eax, DWORD PTR _y1$[ebp]
	push	eax
	mov	ecx, DWORD PTR _x1$[ebp]
	push	ecx
	lea	edx, DWORD PTR _str$[ebp]
	push	edx
	call	_GUI_DispStringAt
	add	esp, 12					; 0000000cH
; Line 255
	call	_GUI_SelectLCD
; Line 256
	mov	eax, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR [eax+48]
$LN7@DrawToMemA:
; Line 258
	push	edx
	mov	ecx, ebp
	push	eax
	lea	edx, DWORD PTR $LN14@DrawToMemA
	call	@_RTC_CheckStackVars@8
	pop	eax
	pop	edx
	pop	edi
	pop	esi
	pop	ebx
	mov	ecx, DWORD PTR __$ArrayPad$[ebp]
	xor	ecx, ebp
	call	@__security_check_cookie@4
	add	esp, 304				; 00000130H
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
$LN14@DrawToMemA:
	DD	2
	DD	$LN13@DrawToMemA
$LN13@DrawToMemA:
	DD	-92					; ffffffa4H
	DD	10					; 0000000aH
	DD	$LN11@DrawToMemA
	DD	-108					; ffffff94H
	DD	8
	DD	$LN12@DrawToMemA
$LN12@DrawToMemA:
	DB	114					; 00000072H
	DB	101					; 00000065H
	DB	99					; 00000063H
	DB	116					; 00000074H
	DB	0
$LN11@DrawToMemA:
	DB	115					; 00000073H
	DB	116					; 00000074H
	DB	114					; 00000072H
	DB	0
?DrawToMemArea@PredictiveLapTimer@@QAEJXZ ENDP		; PredictiveLapTimer::DrawToMemArea
_TEXT	ENDS
END