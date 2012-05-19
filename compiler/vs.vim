" Vim compiler file
" Compiler:	Visual Studio 9.0 compiler
" Maintainer:	yuratomo
" Last Change:	2012.05.19

if exists("current_compiler")
  finish
endif
let current_compiler = "vs"
let s:types = ['msbuild', 'nmake']
let s:min_ver = 8
let s:max_ver = 12

function! vs#list(A, L, P)
  let items = []
  for item in s:types
    if item =~ '^'.a:A
      call add(items, item)
    endif
  endfor
  return items
endfunction

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

if !exists("g:vs_ver")
  let g:vs_ver=input("VisualStudio Version[" .s:min_ver . "-" . s:max_ver . "]: ")
endif

if !exists("g:vs_comp")
  let g:vs_comp=input("Compiler Type[msbuild|nmake]: ", '', "customlist,vs#list")
endif

if g:vs_ver < s:min_ver || g:vs_ver > s:max_ver || index(s:types, g:vs_comp) == -1
  echoerr 'vs.vim configuration error(ver=' . g:vs_ver . ', type=' . g:vs_comp . ')'
else
  let $vs_ver=g:vs_ver
  let $vs_comp=g:vs_comp

  let bat = ''
  for file in split(globpath(&runtimepath, 'bat/vs.bat'), '\n')
    let bat = file
  endfor

  exe 'CompilerSet makeprg=' . bat
  CompilerSet errorformat&
endif
