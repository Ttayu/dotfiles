scriptencoding utf-8
augroup DeniteSettings
  autocmd!
  autocmd FileType denite call s:denite_my_settings()
  autocmd FileType denite-filter call s:denite_filter_my_settings()
  " vimを閉じたらdeniteも同時に閉じる
  autocmd WinEnter * if &filetype == 'denite' && winnr('$') == 1 | q | endif
  autocmd WinEnter * if &filetype == 'denite-filter' && winnr('$') == 1 | q | endif
augroup END

function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> @ denite#do_map('toggle_select').'j'
endfunction

function! s:denite_filter_my_settings() abort
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  imap <buffer> jj <Plug>(denite_filter_update)
  inoremap <silent><buffer> <C-j>
        \ <ESC><C-w>p:call cursor(line('.')+1, 0)<CR><C-w>pA
  inoremap <silent><buffer> <C-k>
        \ <ESC><C-w>p:call cursor(line('.')-1, 0)<CR><C-w>pA
endfunction

call denite#custom#option('default', {
     \ 'prompt': '>',
     \ 'source_names': 'short',
     \ 'split': 'floating',
     \ 'start_filter': v:true,
     \ 'winheight': 12,
     \ 'vertical_preview': v:true,
     \ 'filter_updatetime': 10,
     \ 'unique': v:true,
     \ 'statusline': v:false,
     \ })

" file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
call denite#custom#source('file/old', 'matchers', ['matcher/fruzzy', 'matcher/project_files'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [ '.git/', '*cache*', 'venv/'])
