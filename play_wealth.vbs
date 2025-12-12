Set oPlayer = CreateObject("WMPlayer.OCX")
oPlayer.URL = "wealth.mp3"
oPlayer.settings.setMode "loop", True
oPlayer.controls.play
Do While True
    WScript.Sleep 1000
Loop