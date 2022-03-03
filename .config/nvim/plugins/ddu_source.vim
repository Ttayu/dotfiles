scriptencoding utf-8

augroup DduSettings
  autocmd!
  autocmd FileType ddu-ff call s:ddu_ff_settings()
  autocmd FileType ddu-ff-filter call s:ddu_ff_filter_setttings()
augroup END

function! s:ddu_ff_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> <C-l>
        \ <Cmd>call ddu#ui#ff#do_action('refreshItems')<CR>
  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent> <Esc>
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent> a
        \ <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
  nnoremap <buffer><silent> c
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'cd'})<CR>
  nnoremap <buffer><silent> d
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'delete'})<CR>
  nnoremap <buffer><silent> e
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'edit'})<CR>
  nnoremap <buffer><silent> v
        \ <Cmd>call ddu#ui#ff#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer><silent> N
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'new'})<CR>
  nnoremap <buffer><silent> r
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'quickfix'})<CR>
  nnoremap <buffer><silent> u
        \ <Cmd>call ddu#ui#ff#do_action('updateOptions', {
        \   'sourceOptions': {
        \     '_': {
        \       'matchers': [],
        \     },
        \   },
        \ })<CR>
endfunction

function! s:ddu_ff_filter_setttings() abort
  inoremap <buffer><silent> <CR>
        \ <Esc><Cmd>close<CR>
  inoremap <buffer><silent> jj
        \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
        \ <Cmd>close<CR>
  nnoremap <buffer><silent> <Esc>
        \ <Cmd>close<CR>
endfunction

call ddu#custom#alias('source', 'file_rg', 'file_external')
call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'sourceOptions': {
      \     '_': {
      \       'ignoreCase': v:true,
      \       'matchers': ['matcher_substring'],
      \     },
      \     'file_old': {
      \       'matchers': [
      \         'matcher_fzf', 'matcher_relative', 'matcher_hidden',
      \       ],
      \     },
      \     'file_external': {
      \       'matchers': [
      \         'matcher_fzf', 'matcher_hidden',
      \       ],
      \     },
      \     'file_rec': {
      \       'matchers': [
      \         'matcher_fzf', 'matcher_hidden',
      \       ],
      \     },
      \     'dein': {
      \       'defaultAction': 'cd',
      \     },
      \   },
      \   'sourceParams': {
      \     'file_external': {
      \       'cmd': ['git', 'ls-files', '-co', '--exclude-standard'],
      \     },
      \   },
      \   'uiParams': {
      \     'ff': {
      \       'filterSplitDirection': 'floating',
      \     }
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \     'word': {
      \       'defaultAction': 'append',
      \     },
      \     'help': {
      \       'defaultAction': 'open',
      \     }, 
      \     'action': {
      \       'defaultAction': 'do',
      \     },
      \   }
      \ })
call ddu#custom#patch_local('files', {
      \   'uiParams': {
      \     'ff': {
      \       'split': 'floating',
      \     }
      \   },
      \ })
call ddu#custom#patch_global({
      \   'sourceParams': {
      \     'file_rec': {
      \       'ignoredDirectories': ['.git', '*cache*', '.venv','node_modules', 'build'],
      \     },
      \     'file_rg': {
      \       'cmd': ['rg', '--files', '--glob', '!.git',
      \               '--color', 'never', '--no-messages'],
      \       'updateItems': 50000,
      \     },
      \   }
      \ })
call ddu#custom#patch_global({
      \   'filterParams': {
      \     'matcher_substring': {
      \       'highlightMatched': 'Search',
      \     },
      \   }
      \ })
