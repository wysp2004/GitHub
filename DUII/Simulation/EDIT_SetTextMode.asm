﻿; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.40219.01 

	TITLE	C:\DUII\Simulation\GUI\Widget\EDIT_SetTextMode.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

_BSS	SEGMENT
$SG11382 DB	01H DUP (?)
_BSS	ENDS
PUBLIC	_EDIT_SetTextMode
EXTRN	_WM_InvalidateWindow:PROC
EXTRN	_GUI_ALLOC_UnlockH:PROC
EXTRN	_EDIT__SetCursorPos:PROC
EXTRN	_EDIT_SetText:PROC
EXTRN	_EDIT_LockH:PROC
EXTRN	__RTC_CheckEsp:PROC
EXTRN	__RTC_Shutdown:PROC
EXTRN	__RTC_InitBase:PROC
;	COMDAT rtc$TMZ
; File c:\duii\simulation\gui\widget\edit_settextmode.c
rtc$TMZ	SEGMENT
__RTC_Shutdown.rtc$TMZ DD FLAT:__RTC_Shutdown
rtc$TMZ	ENDS
;	COMDAT rtc$IMZ
rtc$IMZ	SEGMENT
__RTC_InitBase.rtc$IMZ DD FLAT:__RTC_InitBase
; Function compile flags: /Odtp /RTCsu /ZI
rtc$IMZ	ENDS
;	COMDAT _EDIT_SetTextMode
_TEXT	SEGMENT
_pObj$ = -8						; size = 4
_hEdit$ = 8						; size = 4
_EDIT_SetTextMode PROC					; COMDAT
; Line 42
	push	ebp
	mov	ebp, esp
	sub	esp, 204				; 000000ccH
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-204]
	mov	ecx, 51					; 00000033H
	mov	eax, -858993460				; ccccccccH
	rep stosd
; Line 45
	cmp	DWORD PTR _hEdit$[ebp], 0
	je	$LN2@EDIT_SetTe
; Line 46
	mov	eax, DWORD PTR _hEdit$[ebp]
	push	eax
	call	_EDIT_LockH
	add	esp, 4
	mov	DWORD PTR _pObj$[ebp], eax
; Line 47
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	DWORD PTR [eax+92], 0
; Line 48
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	DWORD PTR [eax+96], 0
; Line 49
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	DWORD PTR [eax+76], 0
; Line 50
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	DWORD PTR [eax+80], 0
; Line 51
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	DWORD PTR [eax+64], 0
; Line 52
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	DWORD PTR [eax+68], 0
; Line 53
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	BYTE PTR [eax+72], 0
; Line 54
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	BYTE PTR [eax+90], 0
; Line 55
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	BYTE PTR [eax+88], 0
; Line 56
	push	OFFSET $SG11382
	mov	eax, DWORD PTR _hEdit$[ebp]
	push	eax
	call	_EDIT_SetText
	add	esp, 8
; Line 57
	mov	eax, DWORD PTR _pObj$[ebp]
	mov	ecx, DWORD PTR [eax+80]
	push	ecx
	mov	edx, DWORD PTR _hEdit$[ebp]
	push	edx
	call	_EDIT__SetCursorPos
	add	esp, 8
; Line 58
	call	_GUI_ALLOC_UnlockH
	mov	DWORD PTR _pObj$[ebp], 0
; Line 59
	mov	eax, DWORD PTR _hEdit$[ebp]
	push	eax
	call	_WM_InvalidateWindow
	add	esp, 4
$LN2@EDIT_SetTe:
; Line 62
	pop	edi
	pop	esi
	pop	ebx
	add	esp, 204				; 000000ccH
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
_EDIT_SetTextMode ENDP
_TEXT	ENDS
END