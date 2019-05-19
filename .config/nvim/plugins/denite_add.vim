" Denite用prefix
nnoremap [denite] <Nop>
nmap <Leader>d [denite]

nnoremap <silent> [denite]r
        \ :<C-u>Denite -buffer-name=register
        \ register neoyank<CR>
xnoremap <silent> [denite]r
        \ :<C-u>Denite -default-action=replace -buffer-name=register
        \ register neoyank<CR>

" プロジェクト内のファイル検索
nnoremap <silent> [denite]p :<C-u>Denite file/rec -highlight-mode-insert=Search<CR>
" プロジェクト外のファイル検索
nnoremap <silent> [denite]o :<C-u>Denite file/old -highlight-mode-insert=Search<CR>
" バッファに展開中のファイル検索
nnoremap <silent> [denite]b :<C-u>Denite buffer -highlight-mode-insert=Search<CR>
" ファイル内の関数/クラスなどの検索
nnoremap <silent> [denite]c :<C-u>Denite outline -highlight-mode-insert=Search<CR>
" コマンドラインの履歴の実行
nnoremap <silent> [denite]h :<C-u>Denite command_history<CR>
" dotfiles配下をカレントにしてfile_recを起動
nnoremap <silent> [denite]v :<C-u>Denite file/rec:~/dotfiles/.config/nvim<CR>
" ファイル内検索をDeniteに置き換える
nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-resize line<CR>
