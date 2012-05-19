" Vim compiler file
" Compiler:	Visual Studio 9.0 compiler and Windows Driver Kit
" Maintainer:	yuratomo
" Last Change:	20-May-2012.20

if exists("current_compiler")
  finish
endif
let current_compiler = "vs"
let s:types    = ['msbuild', 'nmake', 'wdk']
let s:wdk_cond = [
  \ 'WXP fre x86',
  \ 'WXP chk x86',
  \ 'WLH fre x86',
  \ 'WLH chk x86',
  \ 'WLH fre x64',
  \ 'WLH chk x64',
  \ 'WNET fre x86',
  \ 'WNET chk x86',
  \ 'WNET fre x64',
  \ 'WNET chk x64',
  \ 'WIN7 fre x86',
  \ 'WIN7 chk x86',
  \ 'WIN7 fre x64',
  \ 'WIN7 chk x64',
  \]
let s:min_ver  = 8
let s:max_ver  = 12

function! vs#comp_list(A, L, P)
  let items = []
  for item in s:types
    if item =~ '^'.a:A
      call add(items, item)
    endif
  endfor
  return items
endfunction

function! vs#wdk_cond_list(A, L, P)
  let items = []
  for item in s:wdk_cond
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

let valid_config = 1

"select compiler
if !exists('g:vs_comp')
  let g:vs_comp=input('Compiler Type[ ' . join(s:types, ', ') . ' ]: ', '', 'customlist,vs#comp_list')
endif
if index(s:types, g:vs_comp) == -1
  let valid_config = 0
endif

if g:vs_comp == 'wdk'
  "resolve wdk base directory
  if !exists('g:vs_wdk_dir')
    let g:vs_wdk_dir='C:\WinDDK\7600.16385.1'
  endif
  if !isdirectory(g:vs_wdk_dir)
    let valid_config = 0
  endif

  "resolve compile condition
  if !exists('g:vs_wdk_cond')
    let g:vs_wdk_cond =input('WDK Compile Condition: ', '', 'customlist,vs#wdk_cond_list')
  endif
  if index(s:wdk_cond, g:vs_wdk_cond) == -1
    let valid_config = 0
  endif

else
  "resolve visual studio version
  if !exists('g:vs_ver')
    let g:vs_ver=input('VisualStudio Version[' .s:min_ver . '-' . s:max_ver . ']: ')
  endif
  if g:vs_ver < s:min_ver || g:vs_ver > s:max_ver
    let valid_config = 0
  endif
endif

if valid_config == 0
  echoerr 'vs.vim configuration error(ver=' . g:vs_ver . ', type=' . g:vs_comp . ', wdk_dir=' . g:vs_wdk_dir . ')'
else
  if g:vs_comp == 'wdk'
    let conds = split(g:vs_wdk_cond, ' ')
    let $vs_comp = 'build'
    let $wdk_dir = g:vs_wdk_dir
    let $wdk_os  = conds[0]
    let $wdk_cond= conds[1]
    let $wdk_cpu = conds[2]
  else
    let $vs_comp = g:vs_comp
    let $vs_ver  = g:vs_ver
  endif

  let bat = ''
  for file in split(globpath(&runtimepath, 'bat/vs.bat'), '\n')
    let bat = file
  endfor

  exe 'CompilerSet makeprg=' . bat
  CompilerSet errorformat&
endif

