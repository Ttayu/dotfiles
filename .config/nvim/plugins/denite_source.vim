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
