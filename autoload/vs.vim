
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

function! vs#resolveVsVersion()
  "resolve visual studio version
  if !exists('g:vs_ver')
    let v = vs#get_version()
    if v.min == -1 || v.max == 1
      echoerr 'Are you install Visual Studio?'
      echoerr 'Can not find environment of Visual Studio.'
      finish
    endif
    if v.min == v.max
      let g:vs_ver = v.min
    else
      let g:vs_ver=input('VisualStudio Version[' . v.min . '-' . v.max . ']: ')
      if g:vs_ver < v.min || g:vs_ver > v.max
        return 0
      endif
    endif
  endif
  return 1
endfunction

function! vs#setVsVersion()
  if exists('g:vs_ver')
    unlet g:vs_ver
  endif
  call vs#resolveVsVersion()
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

function! vs#putFile()
  if vs#resolveVsVersion() == 0
    return
  endif
  echo libcall(g:vsproc_dll_path, 'put_file', 
      \ join([g:vs_ver, line('.'), col('.'), expand('%:p')], ' '))
endfunction

function! vs#getFile()
  if vs#resolveVsVersion() == 0
    return
  endif
  let param = libcall(g:vsproc_dll_path, 'get_file', g:vs_ver)
  let sp = strridx(param, ' ')
  if sp == -1
    return
  endif

  exe 'edit +' . param[ sp+1 : ] . ' ' . param[ 0 : sp-1 ]
endfunction

