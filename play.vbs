Set player = CreateObject("WMPlayer.OCX")
player.URL = "go.mp3"
player.controls.play
While player.playState <> 1
    WScript.Sleep 100
Wend