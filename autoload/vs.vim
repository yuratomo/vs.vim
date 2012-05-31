
let g:vsproc_dll_path =
      \ get(g:, 'vsproc_dll_path', expand('<sfile>:p:h') . '\' .  'vsproc.dll')

function! vs#get_version()
  if exists('g:vs_min_ver') && exists('g:vs_max_ver')
        \ && g:vs_min_ver != -1 && g:vs_max_ver != -1
    return { 'min':g:vs_min_ver , 'max':g:vs_max_ver }
  endif
  let g:vs_min_ver  = -1
  let g:vs_max_ver  = -1

  for v in range(8,20)
    if g:vs_min_ver == -1
      if exists('$VS' . v . '0COMNTOOLS')
        let g:vs_min_ver = v
        let g:vs_max_ver = v
      endif
    else
      if exists('$VS' . v . '0COMNTOOLS')
        let g:vs_max_ver = v
      endif
    endif
  endfor

  if !exists('g:vs_min_ver') || !exists('g:vs_max_ver')
    if !exists('g:vs_min_ver')
      unlet g:vs_min_ver
    endif
    if !exists('g:vs_max_ver')
      unlet g:vs_max_ver
    endif
    return { 'min':-1, 'max':-1 }
  endif

  return { 'min':g:vs_min_ver , 'max':g:vs_max_ver }
endfunction

function! vs#putFile()
  echo libcall(g:vsproc_dll_path, 'put_file', line('.') . ' ' . col('.') . ' ' . expand('%:p'))
endfunction

function! vs#getFile()
  let param = libcall(g:vsproc_dll_path, 'get_file', '')
  echo param
endfunction

