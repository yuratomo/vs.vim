" Vim compiler file
" Compiler:	msbuild
" Maintainer:	yuratomo
" Last Change:	20-May-2012.20

if exists("current_compiler")
  finish
endif
let current_compiler = "msbuild"

let valid_config = 1

"resolve visual studio version
if !exists('g:vs_ver')
  let v = vs#get_version()
  if v.min == -1 || v.max == 1
    echoerr 'Are you install Visual Studio?'
    echoerr 'Can not find environment of Visual Studio.'
    finish
  endif
  if v.min == v.max
    let g:vs_ver = v.min
  else
    let g:vs_ver=input('VisualStudio Version[' . v.min . '-' . v.max . ']: ')
    if g:vs_ver < v.min || g:vs_ver > v.max
      let valid_config = 0
    endif
  endif
endif

if valid_config == 0
  echoerr 'msbuild.vim configuration error(ver=' . g:vs_ver . ')'
else
  let $vs_comp = 'msbuild'
  let $vs_ver  = g:vs_ver

  let bat = ''
  for file in split(globpath(&runtimepath, 'bat/compile.bat'), '\n')
    let bat = file
    break
  endfor

  exe 'CompilerSet makeprg=' . bat
  CompilerSet errorformat&

endif

