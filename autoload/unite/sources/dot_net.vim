" FILE: dot_net.vim
" AUTHOR:  
" Last Modified: 2012.05.27

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#dot_net#define()"{{{
  return s:source
endfunction"}}}

let s:source = {
      \ 'name' : 'dot_net',
      \ 'description' : '.Net Framework Classes',
      \ 'default_action' : 'w3m_msdn_local',
      \ 'action_table' : {},
      \}

let s:classes = [
  \ {'word' : 'System.Windows.Controls.CheckBox'},
  \ {'word' : 'System.sss2'},
  \ {'word' : 'System.sss3'},
  \]

function! s:source.gather_candidates(args, context)"{{{
  return s:classes
endfunction"}}}

let s:source.action_table.w3m_msdn_local = {
      \ 'description' : 'open w3m',
      \ 'is_invalidate_cache' : 1,
      \ 'is_quit' : 0,
      \ 'is_selectable' : 1,
      \ }
function! s:source.action_table.w3m_msdn_local.func(candidates)"{{{
  for candidate in a:candidates
    call w3m#Open(g:w3m#OPEN_NORMAL, 'dot_net', candidate.word)
  endfor
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
