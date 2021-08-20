scriptencoding utf-8
" Denite用prefix
nnoremap [denite] <Nop>
nmap <Leader>d [denite]

" registerの検索
nnoremap <silent> [denite]r
      \ :<C-u>Denite -buffer-name=register
      \ register neoyank<CR>
" スニペットの検索
nnoremap <silent> [denite]s
      \ :<C-u>Denite neosnippet<CR>
" プロジェクト内のファイル検索
nnoremap <silent> [denite]p :<C-u>Denite file/rec<CR>
" プロジェクト外のファイル検索
nnoremap <silent> [denite]o :<C-u>Denite file/old<CR>
" バッファに展開中のファイル検索
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
" ファイル内の関数/クラスなどの検索
nnoremap <silent> [denite]c :<C-u>Denite outline<CR>
" プロジェクト内の関数/クラスなどの検索
nnoremap <silent> [denite]t :<C-u>Denite tag<CR>
" コマンドラインの履歴の実行
nnoremap <silent> [denite]h :<C-u>Denite command_history<CR>
" grep
nnoremap <silent> [denite]g :<C-u>Denite grep<CR>
" dotfiles配下をカレントにしてfile_recを起動
nnoremap <silent> [denite]v :<C-u>Denite file/rec:~/dotfiles/.config/nvim<CR>
" ファイル内検索をDeniteに置き換える
nnoremap <silent> / :<C-u>Denite -start-filter -auto-resize line<CR>
