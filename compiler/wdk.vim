" Vim compiler file
" Compiler:	Visual Studio 9.0 compiler and Windows Driver Kit
" Maintainer:	yuratomo
" Last Change:	20-May-2012.20

if exists("current_compiler")
  finish
endif
let current_compiler = "wdk"
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

function! wdk#wdk_cond_list(A, L, P)
  let items = []
  for item in s:wdk_cond
    if item =~ '^'.a:A
      call add(items, item)
    endif
  endfor
  return items
endfunction

let valid_config = 1

"resolve wdk base directory
if !exists('g:vs_wdk_dir')
  let g:vs_wdk_dir='C:\WinDDK\7600.16385.1'
endif
if !isdirectory(g:vs_wdk_dir)
  let valid_config = 0
endif

"resolve compile condition
if !exists('g:vs_wdk_cond')
  let g:vs_wdk_cond =input('WDK Compile Condition: ', '', 'customlist,wdk#wdk_cond_list')
  if index(s:wdk_cond, g:vs_wdk_cond) == -1
    let valid_config = 0
  endif
  let conds = split(g:vs_wdk_cond, ' ')
  let g:vs_wdk_os   = conds[0]
  let g:vs_wdk_cond = conds[1]
  let g:vs_wdk_cpu  = conds[2]
endif

if valid_config == 0
  echoerr 'wdk configuration error(wdk_dir=' . g:vs_wdk_dir . ')'
else
  let $vs_comp = 'build'
  let $wdk_dir = g:vs_wdk_dir
  let $wdk_os  = g:vs_wdk_os
  let $wdk_cond= g:vs_wdk_cond
  let $wdk_cpu = g:vs_wdk_cpu

  let bat = ''
  for file in split(globpath(&runtimepath, 'bat/compile.bat'), '\n')
    let bat = file
    break
  endfor

  exe 'CompilerSet makeprg=' . bat
  CompilerSet errorformat=%*[0123456789]%*[>]%f(%l)\ :\ %t%*\\D%n:\ %m,%*[^\"]\"%f\"%*\\D%l:\ %m,%f(%l)\ :\ %m,%*[^\ ]\ %f\ %l:\ %m,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,%f\|%l\|\ %m
endif

