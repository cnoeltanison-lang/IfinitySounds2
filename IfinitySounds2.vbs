Set objVoice = CreateObject("SAPI.SpVoice")
Set WshShell = CreateObject("WScript.Shell")
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

' --- 1. INITIAL WARNING ---
strMsg = "ESCAPE first warning: This Virus Will Turn Voice Up To 100." & vbCrLf & _
         "Click 'Yes' to Accept and proceed, or 'No' to Deny and exit."
' Title is "Windows", Yes/No buttons, Critical Icon, System Modal
If MsgBox(strMsg, 4 + 16 + 4096, "Windows") = 7 Then WScript.Quit

' --- 2. WALLPAPER CHANGE (Baldi's Basics) ---
wallpaperPath = WshShell.ExpandEnvironmentStrings("%TEMP%") & "\baldi.jpg"
WshShell.Run "powershell -Command ""Invoke-WebRequest -Uri 'https://nocookie.net' -OutFile '" & wallpaperPath & "'""", 0, True
WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", wallpaperPath
WshShell.Run "%windir%\System32\RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 1, True

' --- 3. THE INSTANT SPAWNING MSGBOX ---
' This launches a background script that does nothing but show the real "Windows" MsgBox
' The "Do...Loop" ensures it spawns every single time you hit OK.
WshShell.Run "cmd /c echo do : msgbox ""ESCAPE"",16+4096,""Windows"" : loop > %temp%\e.vbs && start /b wscript %temp%\e.vbs", 0, False

' --- 4. THE MAIN CHAOS LOOP ---
Do
    ' a. Force Max Volume (0 to 100)
    For i = 0 To 100 : WshShell.SendKeys(chr(&hAF)) : Next

    ' b. Narrator "ESCAPE" (Asynchronous)
    objVoice.Speak "ESCAPE", 1 
    
    ' c. Notepad Trigger for 67 Meme
    Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'notepad.exe'")
    If colProcesses.Count > 0 Then
        WshShell.Run "https://youtube.com"
        WScript.Sleep 5000 ' Buffer to prevent crashing the browser
    End If
    
    WScript.Sleep 100
Loop
