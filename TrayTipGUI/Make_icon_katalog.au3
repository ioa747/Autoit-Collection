
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7
;Make_icon_katalog.au3
; creating icons albums from the dll libraries

#include <StaticConstants.au3>
#include <ScreenCapture.au3>

;Icons Library
Local $Ldll = "C:\Windows\System32\imageres.dll" ;$cnt = 334    --> 0000
$Ldll &= ";C:\Windows\system32\shell32.dll"         ;$cnt = 329 --> 1000
$Ldll &= ";C:\Windows\SysWOW64\wmploc.dll"         ;$cnt = 159  --> 2000
$Ldll &= ";C:\Windows\System32\ddores.dll"         ;$cnt = 149  --> 3000
$Ldll &= ";C:\Windows\System32\mmcndmgr.dll"     ;$cnt = 129    --> 4000
$Ldll &= ";C:\Windows\system32\ieframe.dll"         ;$cnt = 103 --> 5000
$Ldll &= ";C:\Windows\System32\compstui.dll"     ;$cnt = 101    --> 6000
$Ldll &= ";C:\Windows\System32\setupapi.dll"     ;$cnt =  62    --> 7000

$Ldll = StringSplit($Ldll, ";")

For $x = 1 To $Ldll[0]
    ConsoleWrite($Ldll[$x] & @CRLF)
    Example($Ldll[$x], $x)
Next

ShellExecute(@ScriptDir)
Exit

Func Example($IconLib, $Libfactor)
    $Libfactor = ($Libfactor - 1) * 1000
    Local $cnt = _WinAPI_ExtractIconEx($IconLib, -1, 0, 0, 0)
    ConsoleWrite("$cnt = " & $cnt & @CRLF)

    Local $C, $Col, $R, $Row, $BtnSz = 48
    $Col = (@DesktopWidth / 3 * 2) / $BtnSz
    $Row = Int($cnt / $Col)

    Local $hGUI = GUICreate($IconLib, $Col * $BtnSz + $BtnSz, $Row * $BtnSz, 0, 0, -1)

    Local $Icon[$cnt + 1]
    $Icon[0] = 0
    Local $i = 1
    For $R = 0 To $Row
        For $C = 0 To $Col
            ReDim $Icon[UBound($Icon) + 1]

            $Icon[$i] = GUICtrlCreateIcon($IconLib, -1 * $i, $C * $BtnSz, $R * $BtnSz, $BtnSz, $BtnSz)
            GUICtrlCreateLabel($i & " ", $C * $BtnSz, $R * $BtnSz, $BtnSz / 2, 12, $SS_RIGHT)
            ;GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
            GUICtrlSetTip($Icon[$i], "index " & $i)

            $i += 1
        Next
    Next

    GUISetState(@SW_SHOW)

    WinWaitActive($hGUI, "", 5)

    If $Libfactor = 0 Then $Libfactor = "0000"

    Local $WPos = WinGetPos($hGUI)
    ; [0]=X  [1]=Y  [2]=Width  [3]=Height

    ; Capture region
    _ScreenCapture_Capture(@ScriptDir & "\" & $Libfactor & ".jpg", $WPos[0], $WPos[1], $WPos[2], $WPos[3])

    GUIDelete($hGUI)
EndFunc   ;==>Example
