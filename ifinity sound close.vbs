Dim objWMIService, colProcessList, objProcess
Dim strComputer, strFileName

strComputer = "."
strFileName = "IfiniteSound2.vbs" ' Make sure this matches your script's filename

Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

' Query processes where the command line contains the script's filename
Set colProcessList = objWMIService.ExecQuery _
    ("Select * from Win32_Process Where Name = 'wscript.exe' OR Name = 'cscript.exe'")

For Each objProcess in colProcessList
    If InStr(objProcess.CommandLine, strFileName) > 0 Then
        objProcess.Terminate()
    End If
Next

WScript.Quit
