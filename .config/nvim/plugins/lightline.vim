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
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.component.fugitive = ' %{fugitive#head()}'
let g:lightline.component_visible_condition.fugitive = '(exists("*fugitive#head") && ""!=fugitive#head())'
let g:lightline.active = {
      \ 'left': [
      \   ['mode', 'paste'],
      \   ['fugitive'],
      \   ['readonly', 'filename', 'modified'],
      \ ],
      \ 'right': [
      \   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
      \   ['lineinfo'],
      \   ['percent'],
      \   ['fileformat', 'fileencoding', 'filetype']
      \ ],
      \ }
let g:lightline.separator =  { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

" setting ale
let g:lightline#ale#indicator_errors = '✖ '
let g:lightline#ale#indicator_warnings = '⚠ '
let g:lightline#ale#indicator_ok = '✔'

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

