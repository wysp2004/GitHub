﻿; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.40219.01 

	TITLE	C:\DUII\Simulation\GUI\Core\GUI_ClearRectEx.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	_GUI_ClearRectEx
EXTRN	_GUI_ClearRect:PROC
EXTRN	__RTC_CheckEsp:PROC
EXTRN	__RTC_Shutdown:PROC
EXTRN	__RTC_InitBase:PROC
;	COMDAT rtc$TMZ
; File c:\duii\simulation\gui\core\gui_clearrectex.c
rtc$TMZ	SEGMENT
__RTC_Shutdown.rtc$TMZ DD FLAT:__RTC_Shutdown
rtc$TMZ	ENDS
;	COMDAT rtc$IMZ
rtc$IMZ	SEGMENT
__RTC_InitBase.rtc$IMZ DD FLAT:__RTC_InitBase
; Function compile flags: /Odtp /RTCsu /ZI
rtc$IMZ	ENDS
;	COMDAT _GUI_ClearRectEx
_TEXT	SEGMENT
_pRect$ = 8						; size = 4
_GUI_ClearRectEx PROC					; COMDAT
; Line 35
	push	ebp
	mov	ebp, esp
	sub	esp, 192				; 000000c0H
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-192]
	mov	ecx, 48					; 00000030H
	mov	eax, -858993460				; ccccccccH
	rep stosd
; Line 36
	mov	eax, DWORD PTR _pRect$[ebp]
	movsx	ecx, WORD PTR [eax+6]
	push	ecx
	mov	edx, DWORD PTR _pRect$[ebp]
	movsx	eax, WORD PTR [edx+4]
	push	eax
	mov	ecx, DWORD PTR _pRect$[ebp]
	movsx	edx, WORD PTR [ecx+2]
	push	edx
	mov	eax, DWORD PTR _pRect$[ebp]
	movsx	ecx, WORD PTR [eax]
	push	ecx
	call	_GUI_ClearRect
	add	esp, 16					; 00000010H
; Line 37
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 192				; 000000c0H
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
_GUI_ClearRectEx ENDP
_TEXT	ENDS
END