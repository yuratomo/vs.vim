" Vim compiler file
" Compiler:	msbuild
" Maintainer:	yuratomo
" Last Change:	01-Jun-2012.01

if exists("current_compiler")
  finish
endif
let current_compiler = "msbuild"

if exists('bg#api#add_completion')
  call bg#api#add_completion(
    \[
    \ '/t:Clean ',
    \ '/t:Build ',
    \ '/t:Rebuile ',
    \ '/t:Compile ',
    \ '/t:Run ',
    \ '/p:Configuration=Release ',
    \ '/p:Configuration=Debug ',
    \ '/p:Platform=Win32 ',
    \ '/p:Platform=x64 ',
    \ '/p:Platform=AnyCPU ',
    \]
  \)
endif

let valid_config = vs#resolveVsVersion()
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

  exe 'CompilerSet makeprg=' . escape(bat, ' \')
  CompilerSet errorformat&
endif

