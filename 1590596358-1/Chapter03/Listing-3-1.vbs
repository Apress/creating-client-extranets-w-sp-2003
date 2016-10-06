' Backup the WSS sites...
' -------------------------------
Const STSADM_PATH =   _
  "C:\Program Files\Common Files\Microsoft Shared\” & _
  “web server extensions\60\BIN\stsadm"
Dim objFso, objFolder, objFiles, objFile, objShell, objExec
Dim strResult, objXml, objSc, objUrl, strUrl 
Dim strFileName, strCmd 
Set objFso = CreateObject("Scripting.FileSystemObject")

' Delete all backup files currently present in the backup folder.
Set objFolder = objFso.GetFolder("\\extwss01\WSSBackups\")
Set objFiles = objFolder.Files
For Each objFile in objFiles
  objFile.Delete(True)
Next

' Retrieve all site collections in XML format.
Set objShell = CreateObject("WScript.Shell")
Set objExec = objShell.Exec(STSADM_PATH & " -o enumsites -url http://extwss01/")
strResult = objExec.StdOut.ReadAll

' Load XML in DOM document so it can be processed.
Set objXml = CreateObject("MSXML2.DOMDocument")
objXml.LoadXML(strResult)

' Loop through each site collection and call stsadm.exe to make a backup.
For Each objSc in objXml.DocumentElement.ChildNodes
    strUrl = objSc.Attributes.GetNamedItem("Url").Text
    strFileName = "\\extwss01\WSSBackups\" & _
       Replace(Replace(strUrl, "http://", ""), "/", "_") & _ 
       ".bak"
    strCmd = STSADM_PATH & " -o backup -url """ + strUrl & _
       + """ -filename """ + strFileName + """" 
    objShell.Exec(strCmd)
Next

WScript.Echo "WSS Backup complete."
