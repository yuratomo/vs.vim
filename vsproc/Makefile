all: ..\autoload\vsproc.dll

..\autoload\vsproc.dll: vsproc.cpp
	cl /LD /clr /FUenvdte.dll /AI"C:\Program Files\Common Files\Microsoft Shared\MSEnv\PublicAssemblies" /AI"C:\Program Files (x86)\Common Files\Microsoft Shared\MSEnv\PublicAssemblies" vsproc.cpp /Fe../autoload/vsproc.dll

clean:
	cmd /C "del ..\autoload\vsproc.dll ..\autoload\vsproc.lib ..\autoload\vsproc.exp" /F /Q

