" Denite用prefix
nnoremap [denite] <Nop>
nmap <Leader>d [denite]

" プロジェクト内のファイル検索
nnoremap <silent> [denite]p :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
" バッファに展開中のファイル検索
nnoremap <silent> [denite]b :<C-u>Denite buffer -highlight-mode-insert=Search<CR>
" ファイル内の関数/クラスなどの検索
nnoremap <silent> [denite]o :<C-u>Denite outline -highlight-mode-insert=Search<CR>
" コマンドラインの履歴の実行
nnoremap <silent> [denite]h :<C-u>Denite command_history<CR>
" レジスタの検索
nnoremap <silent> [denite]r :<C-u>Denite register<CR>
" dotfiles配下をカレントにしてfile_recを起動
nnoremap <silent> [denite]v :<C-u>call denite#start([{'name': 'file_rec', 'args': ['~/dotfiles']}]) outline -highlight-mode-insert=Search=Search<CR>

" ノーマルモードで起動、jjでノーマルへ
call denite#custom#option('default', {'mode': 'normal'})
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>')

" 上下移動を<C-j>, <C-k>
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>')

" 上下履歴移動を<C-n>, <C-p>
call denite#custom#map('insert', '<C-p>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-n>', '<denite:assign_previous_text>')
" 横割りオープンを<C-s>
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>')
call denite#custom#map('normal', 's', '<denite:do_action:split>')
" 縦割りオープンを<C-v>
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>')
" タブオープンを<C-t>
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>')

" file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs', [ '.git/', '__pycache__/', 'venv/'])

" ファイル内検索をDeniteに置き換える
nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-resize line<CR>
