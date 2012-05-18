" Vim compiler file
" Compiler:	Visual Studio 9.0 nmake
" Maintainer:	yuratomo
" Last Change:	2012.05.18

if exists("current_compiler")
  finish
endif
let current_compiler = "vs"

function! vs#list(A, L, P)
  let items = []
  for item in ['msbuild', 'nmake']
    if item =~ '^'.a:A
      call add(items, item)
    endif
  endfor
  return items
endfunction

if exists('g:bg_completion_items')
  call extend(
    \g:bg_completion_items, 
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
  let g:vs_ver = ''
endif
let $vs_ver=input("VisualStudio Version[8-10]: ", g:vs_ver)
let g:vs_ver=$vs_ver

if !exists("g:vs_comp")
  let g:vs_comp = ''
endif
let $vs_comp=input("Compiler Type[msbuild|nmake]: ", g:vs_comp, "customlist,vs#list")
let g:vs_comp=$vs_comp

let bat = ''
for file in split(globpath(&runtimepath, 'bat/vs.bat'), '\n')
  let bat = file
endfor

exe 'CompilerSet makeprg=' . bat
CompilerSet errorformat=
  \%E%f(%l):\ error\ %m,
  \%W%f(%l):\ warning\ %m,
  \%E%f(%l\\,%c):\ error\ %m,
  \%W%f(%l\\,%c):\ warning\ %m,
  \%-G%.%#

