Set wp = GetObject("winmgmts:{impersonationLevel=impersonate}").ExecQuery("select * from Win32_Process where Name='HelpLibAgent.exe'")
for each p in wp
  Wscript.StdOut.WriteLine p.ProcessId
Next
Set wp = Nothing

