" File: plugin/vs.vim
" Last Modified: 2012.05.19
" Version: 0.2.0
" Author: yuratomo (twitter @yusetomo)

if exists('g:loaded_vs') && g:loaded_vs == 1
  finish
endif

function! vs#set(version,compiler)
  let g:vs_ver=a:version
  let g:vs_comp=a:compiler
endfunction

let g:loaded_vs = 1
