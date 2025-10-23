;Example2.au3  -  Example for using TrayTipGUI

#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7

Tip("so You can present the messages easy" & @CRLF & "  without title")

Sleep(3000)

Tip("as you see It is more efficient to write")

Sleep(3000)

Tip("in the sense that you don't need an icon and a title every time")

Sleep(4000)

Tip("Of course, if you need them, you can put them on", "New Title...", 5, 2132)

Sleep(4000)

;----------------------------------------------------------------------------------------
Func Tip($Msg, $Title = "info", $Timeout = 3, $Icon = 2060)
    Local $FilePath = @ScriptDir & "\TrayTipGUI.au3"
    Local $Param = '"' & $Title & '" "' & $Msg & '" "' & $Timeout & '" "' & $Icon & '"'
    Run(FileGetShortName(@AutoItExe) & " " & FileGetShortName($FilePath) & " " & $Param)
EndFunc   ;==>Tip
;----------------------------------------------------------------------------------------
