" Vim compiler file
" Compiler:	nmake
" Maintainer:	yuratomo
" Last Change:	01-Jun-2012.20

if exists("current_compiler")
  finish
endif
let current_compiler = "nmake"

let valid_config = vs#resolveVsVersion()
if valid_config == 0
  echoerr 'nmake.vim configuration error(ver=' . g:vs_ver . ')'
else
  let $vs_comp = 'nmake'
  let $vs_ver  = g:vs_ver

  let bat = ''
  for file in split(globpath(&runtimepath, 'bat/compile.bat'), '\n')
    let bat = file
    break
  endfor

  exe 'CompilerSet makeprg=' . escape(bat, ' \')
  CompilerSet errorformat&
endif

