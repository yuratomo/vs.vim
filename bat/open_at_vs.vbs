If WScript.Arguments.Count < 4 Then
  WScript.Quit
End If
ver  = WScript.Arguments(0)
file = WScript.Arguments(1)
line = WScript.Arguments(2)
col  = WScript.Arguments(3)

Set dte = CreateObject("VisualStudio.DTE." + ver + ".0")
If dte <> Null Then
  Set io  = dte.ItemOperations
  Set rc  = io.OpenFile(file)
  Set sel = dte.ActiveDocument.Selection
  Call sel.MoveToLineAndOffset (line, col)
  Set sel = Nothing
  Set rc  = Nothing
  Set io  = Nothing
End If
Set dte = Nothing
