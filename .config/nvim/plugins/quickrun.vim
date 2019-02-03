let g:quickrun_no_default_key_mappings = 1
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner': 'vimproc',
      \ 'runner/vimproc/updatetime': 10,
      \ 'outputter': 'error',
      \ 'outputter/error/success': 'buffer',
      \ 'outputter/error/error': 'quickfix',
      \ 'outputter/buffer/split': ':botright 4sp',
      \ 'outputter/buffer/close_on_empty': 1,
      \ 'outputter/buffer/running_mark': 'Running...',
      \}
nnoremap <silent> <C-q> :QuickRun<CR>
"atcoder用
nnoremap <silent> <Leader>q :QuickRun <input.txt<CR>
" clipboardを入力にし実行
nnoremap <silent> <Leader>r :QuickRun -input =@+<CR>
" qでquickfixを閉じるようにする
au FileType qf nnoremap <silent><buffer>q :quit<CR>
" <C-c>でquickrunを停止
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
