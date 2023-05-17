scriptencoding utf-8
if ! exists('g:lightline')
  let g:lightline = {}
endif
if ! has_key(g:lightline, 'component')
  let g:lightline.component = {}
endif
if ! has_key(g:lightline, 'component_visible_condition')
  let g:lightline.component_visible_condition = {}
endif
let g:lightline.colorscheme = 'tokyonight'
let g:lightline.component.gitbranch = ' %{gitbranch#name()}'

let g:lightline.active = {
      \ 'left': [
      \   ['mode', 'paste'],
      \   ['gitbranch'],
      \   ['readonly', 'relativepath', 'modified', 'method'],
      \ ],
      \ 'right': [
      \   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'asyncrun_failure', 'asyncrun_running'],
      \   ['lineinfo'],
      \   ['percent'],
      \   ['fileformat', 'fileencoding', 'filetype']
      \ ],
      \ }
let g:lightline.separator =  { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

" setting lsp
let g:lightline#lsp#indicator_errors = '✖ '
let g:lightline#lsp#indicator_warnings = '⚠ '
let g:lightline#lsp#indicator_infos = ' '
let g:lightline#lsp#indicator_ok = '✔'
let g:lightline#lsp#update_in_insert = v:false

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#lsp#checking',
      \  'linter_warnings': 'lightline#lsp#warnings',
      \  'linter_errors': 'lightline#lsp#errors',
      \  'linter_infos': 'lightline#lsp#infos',
      \  'linter_ok': 'lightline#lsp#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_infos': 'left',
      \     'linter_ok': 'left',
      \ }
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
let g:lightline.component_function = {
      \ 'method': 'NearestMethodOrFunction'
      \ }

call extend(g:lightline.component_expand, {
      \   'asyncrun_failure': 'AsyncRunFailure',
      \   'asyncrun_running': 'AsyncRunRunning',
      \ })
call extend(g:lightline.component_type, {
      \   'asyncrun_failure': 'error',
      \   'asyncrun_running': 'warning',
      \ })

function! AsyncRunFailure() abort
  if g:asyncrun_status ==# 'failure'
    return toupper(g:asyncrun_status)
  else
    return ''
  endif
endfunction

function! AsyncRunRunning() abort
  if g:asyncrun_status ==# 'running'
    return toupper(g:asyncrun_status)
  else
    return ''
  endif
endfunction

augroup AsyncRunUpdateLightline
  autocmd!
  autocmd User AsyncRunStop call lightline#update()
  autocmd User AsyncRunStart call lightline#update()
augroup END
