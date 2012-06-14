// vsproc.cpp : DLL アプリケーション用にエクスポートされる関数を定義します。
//

#include "stdio.h"
#include "string.h"
#include "stdlib.h"
#include < vcclr.h >

#ifdef __cplusplus
#define VSAPI extern "C" __declspec(dllexport)
#else
#define VSAPI __declspec(dllexport)
#endif

static char _result[1024];

using namespace System;
using namespace EnvDTE;

EnvDTE::DTE^ get_dte(int ver)
{
	String^ name = "VisualStudio.DTE";
  if (ver >= 8) {
    name += "." + ver + ".0";
  }
	EnvDTE::DTE^ dte = nullptr;

	try {
		dte = (EnvDTE::DTE^)System::Runtime::InteropServices::Marshal::GetActiveObject(name);
	}
	catch (Exception^ e)
	{
		System::Type^ type = System::Type::GetTypeFromProgID(name);
		if (type != nullptr) {
			dte = (EnvDTE::DTE^)System::Activator::CreateInstance(type);
		} else {
			return nullptr;
		}
	}
	return dte;
}

/*
VSAPI const int set_version(int version)
{
	return version;
}
*/

VSAPI const char* put_file(char* str)
{	
	int ver = 0;
	int line = 0;
	int col = 0;
	pin_ptr<const wchar_t> wch = nullptr;

	char* space = NULL;
	char* ptr = str;
	for (int idx=0; idx<3; idx++) {
		space = strchr(ptr, ' ');
		if (space == NULL) {
			space = strchr(ptr, '\t');
		}
		if (space == NULL) {
			return "illegal parameter";
		}
		ptr = space+1;
	}

	sscanf(str, "%d %d %d", &ver, &line, &col);
	String^ file = gcnew String(ptr);

	EnvDTE::DTE^ dte = get_dte(ver);
	if (dte == nullptr) {
		_sprintf_p(_result, _countof(_result), 
			"Can not get DTE object. Are you installed Visual Studio (not Express)?");
		return _result;
	}
	
	try {
		dte->UserControl = true;
		dte->MainWindow->Visible = true;
	} catch (Exception^ e) {
	}

	try {
		dte->ItemOperations->OpenFile(Convert::ToString(file), EnvDTE::Constants::vsViewKindTextView);
		TextSelection^ sel = (TextSelection^)dte->ActiveDocument->Selection;
		sel->MoveToLineAndOffset(line, col, false);
		dte->MainWindow->Activate();
	} catch (Exception^ e) {
		_sprintf_p(_result, _countof(_result), 
			"DTE Operation Error.(%s)", PtrToStringChars(e->ToString()));
		return _result;
	}

	return NULL;
}

VSAPI const char* get_file(char* str)
{
	EnvDTE::DTE^ dte = get_dte(atoi(str));
	if (dte == nullptr) {
		_sprintf_p(_result, _countof(_result), 
			"Can not get DTE object. Are you installed Visual Studio (not Express)?");
		return _result;
	}

	EnvDTE::Document^ doc = dte->ActiveDocument;
	if (doc == nullptr) {
		_sprintf_p(_result, _countof(_result), "Can not get DTE Active Document object. ");
		return _result;
	};

	EnvDTE::TextSelection^ tsel = (EnvDTE::TextSelection^)doc->Selection;
	
	String^ ret_str = doc->Path + doc->default + " " + tsel->ActivePoint->Line;

	pin_ptr<const wchar_t> wch = PtrToStringChars(ret_str);
	sprintf_s(_result, "%S\n", wch);
	return _result;
}

