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
  inoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  inoremap <silent><buffer> <C-j>
        \ <ESC><C-w>p:call cursor(line('.')+1, 0)<CR><C-w>pA
  inoremap <silent><buffer> <C-k>
        \ <ESC><C-w>p:call cursor(line('.')-1, 0)<CR><C-w>pA
endfunction

let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7
call denite#custom#option('default', {
     \ 'prompt': '>',
     \ 'source_names': 'short',
     \ 'split': 'floating',
     \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
     \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
     \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
     \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
     \ 'start_filter': v:true,
     \ 'vertical_preview': v:true,
     \ 'filter_updatetime': 10,
     \ 'unique': v:true,
     \ 'statusline': v:false,
     \ })

if executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
else
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

" file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
call denite#custom#source('file/old', 'matchers', ['matcher/fruzzy', 'matcher/project_files'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [ '.git/', '*cache*', 'venv/'])
