augroup DduFfSettings
  autocmd!
  autocmd FileType ddu-ff call s:ddu_ff_settings()
  autocmd FileType ddu-ff-filter call s:ddu_ff_filter_setttings()
augroup END

function! s:ddu_ff_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> <C-l>
        \ <Cmd>call ddu#ui#do_action('refreshItems')<CR>
  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#do_action('preview')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer><silent> <Esc>
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer><silent> a
        \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
  nnoremap <buffer><silent> c
        \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'cd'})<CR>
  nnoremap <buffer><silent> d
        \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>
  nnoremap <buffer><silent> e
        \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'edit'})<CR>
  nnoremap <buffer><silent> v
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer><silent> N
        \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'new'})<CR>
  nnoremap <buffer><silent> r
        \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'quickfix'})<CR>
  nnoremap <buffer><silent> yy
        \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>
  nnoremap <buffer><silent> n
        \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>
  nnoremap <buffer><silent> u
        \ <Cmd>call ddu#ui#do_action('updateOptions', {
        \   'sourceOptions': {
        \     '_': {
        \       'matchers': [],
        \     },
        \   },
        \ })<CR>
endfunction

function! s:ddu_ff_filter_setttings() abort
  inoremap <buffer><silent> <CR>
        \ <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
  inoremap <buffer><silent> jj
        \ <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
  nnoremap <buffer><silent> <Esc>
        \ <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  inoremap <buffer> <C-p> <Up><Esc>A
  inoremap <buffer> <C-n> <Down><Esc>A
  inoremap <buffer> <C-j>
        \ <Cmd>call ddu#ui#do_action('cursorNext')<CR>
  inoremap <buffer> <C-k>
        \ <Cmd>call ddu#ui#do_action('cursorPrevious')<CR>
endfunction
