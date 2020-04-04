
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
Menu, Tray, Icon, Context_32.ico
;run SetWindowCompositionAttribute.exe class #32768  blur true
;run SetWindowCompositionAttribute.exe class #32768  accent 3 0 0 0
SetWinDelay, 0
DetectHiddenWindows on
global EVENT_SYSTEM_MENUPOPUPSTART := 0x0006
;
OnPopupMenu(hWinEventHook, event, hWnd, idObject, idChild, dwEventThread, dwmsEventTime) {
thisFntSize := 25
    bgrColor := "220022"
      ; WinSet, Transparent, 0 , ahk_id %hWnd%
;sleep, 100
;WinSet, Transparent, 150 , ahk_id %hWnd%
;WinSet, enable
SetAcrylicGlassEffect(bgrColor, 100, ahk_id, hWnd)
        ;WinSet, Transparent, 150 , ahk_id %hWnd%
;run SetWindowCompositionAttribute.exe hwnd %hWnd%  blur true
;run SetWindowCompositionAttribute.exe hwnd %hWnd%  accent 1 1 0 0
;MsgBox:
;WinGetTitle, Title, ahk_id 32768
; WinGetClass, Class, ahk_id 32768	
;TrayTip, gtytyt,Title:%hwnd%
}
SetAcrylicGlassEffect(thisColor, thisAlpha, ahk_id, hWnd) {
  
SetWinDelay, 0
    initialAlpha := thisAlpha
    If (thisAlpha<16)
       thisAlpha := 16
    Else If (thisAlpha>125)
       thisAlpha :=20


    thisColor := ConvertToBGRfromRGB(thisColor)
    thisAlpha := Format("{1:#x}", thisAlpha)
    gradient_color := thisAlpha . thisColor

    Static init, accent_state := 4, ver := DllCall("GetVersion") & 0xff < 10
    Static pad := A_PtrSize = 8 ? 4 : 0, WCA_ACCENT_POLICY := 19
    accent_size := VarSetCapacity(ACCENT_POLICY, 16, 0)
    NumPut(accent_state, ACCENT_POLICY, 0, "int")

    If (RegExMatch(gradient_color, "0x[[:xdigit:]]{8}"))
       NumPut(gradient_color, ACCENT_POLICY, 8, "int")

    VarSetCapacity(WINCOMPATTRDATA, 4 + pad + A_PtrSize + 4 + pad, 0)
    && NumPut(WCA_ACCENT_POLICY, WINCOMPATTRDATA, 0, "int")
    && NumPut(&ACCENT_POLICY, WINCOMPATTRDATA, 4 + pad, "ptr")
    && NumPut(accent_size, WINCOMPATTRDATA, 4 + pad + A_PtrSize, "uint")
    If !(DllCall("user32\SetWindowCompositionAttribute", "ptr", hWnd, "ptr", &WINCOMPATTRDATA))
       Return
SetWinDelay, 0
    thisOpacity := (initialAlpha<16) ? 60 + initialAlpha*9 : 250
    ;WinSet, Transparent, 50, hWindow
;WinSet, Transparent, 50 , ahk_id %hWnd%
    Return
}
ConvertToBGRfromRGB(RGB) { ; Get numeric BGR value from numeric RGB value or HTML color name
  ; HEX values
  BGR := SubStr(RGB, -1, 2) SubStr(RGB, 1, 4) 
  Return BGR 
}

;run SetWindowCompositionAttribute.exe class 32768 active 1
;pause
;WinGet, hWnd, ID, ahk_class #32768
	
;WinSet, Transparent, 150 , ahk_id %hWnd%

 AtExit()
{
WinSet, Transparent, 100 , ahk_id %hWnd%
	global hWinEventHook, lpfnWinEventProc
	if (hWinEventHook)
		DllCall("UnhookWinEvent", "Ptr", hWinEventHook), hWinEventHook := 0
	if (lpfnWinEventProc)
		DllCall("GlobalFree", "Ptr", lpfnWinEventProc, "Ptr"), lpfnWinEventProc := 0	
	return 0
}

OnExit("AtExit")

hWinEventHook := DllCall("SetWinEventHook", "UInt", EVENT_SYSTEM_MENUPOPUPSTART, "UInt", EVENT_SYSTEM_MENUPOPUPSTART, "Ptr", 0, "Ptr", (lpfnWinEventProc := RegisterCallback("OnPopupMenu", "")), "UInt", 0, "UInt", 0, "UInt", WINEVENT_OUTOFCONTEXT := 0x0000 | WINEVENT_SKIPOWNPROCESS := 0x0002)


 

