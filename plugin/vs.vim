" File: plugin/vs.vim
" Last Modified: 2012.05.20
" Version: 0.3.0
" Author: yuratomo (twitter @yusetomo)

if exists('g:loaded_vs') && g:loaded_vs == 1
  finish
endif

function! vs#set_vs(compiler,version)
  let g:vs_ver  = a:version
  let g:vs_comp = a:compiler
endfunction

function! vs#set_wdk(cond,cpu,os)
  let g:vs_comp     = 'wdk'
  let g:vs_wdk_cond = a:cond
  let g:vs_wdk_cpu  = a:cpu
  let g:vs_wdk_os   = a:os
endfunction

function! vs#clear()
  unlet g:vs_comp
  unlet g:vs_ver
  unlet g:vs_wdk_dir
  unlet g:vs_wdk_cond
  unlet g:vs_wdk_cpu
  unlet g:vs_wdk_os
endfunction

let g:loaded_vs = 1
