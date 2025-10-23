#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7
;TrayTipGUI.au3
; custom GUI to send a message to the tray

#NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>

Local $MinY
Local $iParams = $CmdLine[0]
If Not $iParams Then ; examle if no parameters
    Local $iParams[5] = [4, "   * This is an example...", _
            "This means that you have run the " & @CRLF _
             & "    -->  " & @ScriptName & "  <--  " & @CRLF & @CRLF _
             & " without command line parameters." & @CRLF _
             & " and for this reason act as demo.", 10, 2061]
Else
    $iParams = $CmdLine
EndIf

TrayTipGUI($iParams[1], $iParams[2], $iParams[3], $iParams[4])

Exit

Func TrayTipGUI($Title, $Msg, $Timeout = 5, $Icon = 0)
    ;Colors for the TrayMsg GUI.    0x14171b; 0xFFFFFF; 0xBBBBBB;
    Local $BackColor = 0x14171b, $TitleColor = 0xFFFFFF, $MsgColor = 0xBBBBBB

    ;Get DeskTop size
    Local $DTs = WinGetPos("[CLASS:Shell_TrayWnd]")
    ConsoleWrite("X=" & $DTs[0] & " Y=" & $DTs[1] & " W=" & $DTs[2] & " H=" & $DTs[3] & @CRLF)
    ; X=0 Y=1040 W=1920 H=40 * <--- main value

    $MinY = $DTs[1]

    ;get the cnt of @TrayTipGUI
    Local $WinCnt = GetTrayCnt() + 1
    ConsoleWrite("$WinCnt=" & $WinCnt & @CRLF)

    ;GUI
;~  Local $hGUI = GUICreate("@TrayTipGUI", 450, 150, @DesktopWidth - 460, @DesktopHeight, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
    Local $hGUI = GUICreate("@TrayTipGUI", 450, 150, $DTs[2] - 460, $DTs[1] + $DTs[3], $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))

    GUISetBkColor($BackColor)
    WinSetTrans($hGUI, "", 245) ; * <-- transparency seting range 0 - 255

    ;Exit button
    Local $idExit = GUICtrlCreateButton("X", 427, 3, 20, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "Arial")
    GUICtrlSetBkColor(-1, $BackColor)
    GUICtrlSetColor(-1, $TitleColor)

    ;Title
    GUICtrlCreateLabel($Title, 10, 10, 410, 35)
    GUICtrlSetFont(-1, 11, 600, 0, "Arial")
    GUICtrlSetColor(-1, $TitleColor)
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

    ;Msg
    Local $idMsg = GUICtrlCreateLabel($Msg, 80, 50, 360, 95)
    GUICtrlSetFont(-1, 11, 600, 0, "Arial")
    GUICtrlSetColor(-1, $MsgColor)
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

;~ ************ Icons Library **************************
;~ C:\Windows\System32\imageres.dll $cnt = 334  --> 0000
;~ C:\Windows\system32\shell32.dll  $cnt = 329  --> 1000
;~ C:\Windows\SysWOW64\wmploc.dll   $cnt = 159  --> 2000
;~ C:\Windows\System32\ddores.dll   $cnt = 149  --> 3000
;~ C:\Windows\System32\mmcndmgr.dll $cnt = 129  --> 4000
;~ C:\Windows\system32\ieframe.dll  $cnt = 103  --> 5000
;~ C:\Windows\System32\compstui.dll $cnt = 101  --> 6000
;~ C:\Windows\System32\setupapi.dll $cnt =  62  --> 7000

    Switch $Icon

        Case 1 To 334 ; icon from C:\Windows\System32\imageres.dll  $cnt = 334
            GUICtrlCreateIcon("imageres.dll", $Icon * -1, 10, 43, 64, 64)

        Case 1001 To 1329 ; icon from C:\Windows\system32\shell32.dll   $cnt = 329
            $Icon -= 1000
            GUICtrlCreateIcon("shell32.dll", $Icon * -1, 10, 43, 64, 64)

        Case 2001 To 2159 ; icon from C:\Windows\SysWOW64\wmploc.dll    $cnt = 159
            $Icon -= 2000
            GUICtrlCreateIcon("wmploc.dll", $Icon * -1, 10, 43, 64, 64)

        Case 3001 To 3149 ; icon from C:\Windows\System32\ddores.dll    $cnt = 149
            $Icon -= 3000
            GUICtrlCreateIcon("shell32.dll", $Icon * -1, 10, 43, 64, 64)

        Case 4001 To 4129 ; icon from C:\Windows\System32\mmcndmgr.dll  $cnt = 129
            $Icon -= 4000
            GUICtrlCreateIcon("mmcndmgr.dll", $Icon * -1, 10, 43, 64, 64)

        Case 5001 To 5103 ; icon from C:\Windows\system32\ieframe.dll   $cnt = 103
            $Icon -= 5000
            GUICtrlCreateIcon("ieframe.dll", $Icon * -1, 10, 43, 64, 64)

        Case 6001 To 6101 ; icon from C:\Windows\System32\compstui.dll  $cnt = 101
            $Icon -= 6000
            GUICtrlCreateIcon("compstui.dll", $Icon * -1, 10, 43, 64, 64)

        Case 7001 To 7062 ; icon from C:\Windows\System32\setupapi.dll  $cnt = 62
            $Icon -= 7000
            GUICtrlCreateIcon("setupapi.dll", $Icon * -1, 10, 43, 64, 64)

        Case Else
            Local $tmp = StringSplit($Icon, ",")
            If $tmp[0] = 1 Then ; single icon file
                If $tmp[1] = 0 Then ; if no icon maximize the msg
                    GUICtrlSetPos($idMsg, 10, 48, 440, 97) ; 80, 50, 360, 90
                Else ; single icon file
                    GUICtrlCreateIcon($tmp[1], -1, 10, 43, 64, 64)
                EndIf

            ElseIf $tmp[0] = 2 Then ; if .dll file with icon index
                GUICtrlCreateIcon($tmp[1], $tmp[2] * -1, 10, 43, 64, 64)

            Else ; unknown situation
                MsgBox(0, "Else unknown situation", $Icon)
            EndIf

    EndSwitch

    GUISetState(@SW_SHOW, $hGUI)

    ;shows up the GUI
    Local $WPos = WinGetPos($hGUI)
    ;[0]=X; [1]=Y; [2]=Width; [3]=Height
    WinMove($hGUI, "", $WPos[0], $MinY - 150 - 10, $WPos[2], $WPos[3], 5)

    ; Begin the timer and store the handle
    Local $hTimer, $fDiff
    $hTimer = TimerInit()

    ;*******************************************
    Do    ; Loop until the TimerDiff > $Timeout
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idExit
                ExitLoop
        EndSwitch

        Sleep(100)

        ;Find the difference in time from the previous call of TimerInit
        $fDiff = TimerDiff($hTimer)

    Until $fDiff > $Timeout * 1000
    ;*******************************************

    ;disappear the GUI
    WinMove($hGUI, "", $WPos[0], @DesktopHeight, $WPos[2], $WPos[3], 5)

    ;Delete the previous GUI and all controls.
    GUIDelete($hGUI)
EndFunc   ;==>TrayTipGUI
;----------------------------------------------------------------------------------------
Func GetTrayCnt()    ;get the cnt of @TrayTipGUI
    Local $aData = _WinAPI_EnumDesktopWindows(_WinAPI_GetThreadDesktop(_WinAPI_GetCurrentThreadId()))
    Local $WinTitle, $WCnt, $WinPos
    For $i = 1 To $aData[0][0]
        $WinTitle = WinGetTitle($aData[$i][0])
        If $WinTitle = "@TrayTipGUI" Then
            $WinPos = WinGetPos($aData[$i][0])
            If $WinPos[1] < $MinY Then $MinY = $WinPos[1]
            $WCnt += 1
        EndIf
    Next
    Return $WCnt
EndFunc   ;==>GetTrayCnt
;----------------------------------------------------------------------------------------
