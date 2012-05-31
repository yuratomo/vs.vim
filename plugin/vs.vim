" File: plugin/vs.vim
" Last Modified: 2012.05.20
" Version: 0.3.0
" Author: yuratomo (twitter @yusetomo)

if exists('g:loaded_vs') && g:loaded_vs == 1
  finish
endif

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

function! vs#clear()
  unlet g:vs_ver
  unlet g:vs_wdk_dir
  unlet g:vs_wdk_cond
  unlet g:vs_wdk_cpu
  unlet g:vs_wdk_os
endfunction

function! vs#show()
  if exists('g:vs_ver')
  exe 'echo "Target VisualStudio version is ' . g:vs_ver . '."'
  endif
  if exists('g:vs_wdk_dir')
  exe 'echo "WDK path is ' . "'" .  escape(g:vs_wdk_dir, ' \') . "'" . '."'
  endif
  exe 'echo "WDK condition is ' . g:vs_wdk_cond . '."'
  exe 'echo "WDK target cpu is ' . g:vs_wdk_cpu . '."'
  exe 'echo "WDK target os is ' . g:vs_wdk_os . '."'
endfunction
command! -nargs=0 VsShow :call vs#show()

command! -nargs=0 VsPutFile :call vs#putFile()
command! -nargs=0 VsGetFile :call vs#getFile()

let g:loaded_vs = 1
