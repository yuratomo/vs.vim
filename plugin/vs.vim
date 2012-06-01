" File: plugin/vs.vim
" Last Modified: 2012.06.01
" Version: 0.4.0
" Author: yuratomo (twitter @yusetomo)

if exists('g:loaded_vs') && g:loaded_vs == 1
  finish
endif

command! -nargs=0 VsShow    :call vs#show()
command! -nargs=0 VsPutFile :call vs#putFile()
command! -nargs=0 VsGetFile :call vs#getFile()
command! -nargs=0 VsSetVersion :call vs#setVsVersion()

let g:loaded_vs = 1
