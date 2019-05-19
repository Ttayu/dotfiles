call denite#custom#option('default', {
     \ 'auto_accel': v:true,
     \ 'promt': '>',
     \ 'source_names': 'short',
     \ 'split': 'floating',
     \ })

" jjでノーマルへ
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>', 'noremap')

" 上下移動を<C-j>, <C-k>
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" 横割りオープンを<C-s>
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 's', '<denite:do_action:split>', 'noremap')
" 縦割りオープンを<C-v>
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>', 'noremap')
" タブオープンを<C-t>
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')

" file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
call denite#custom#source('file/old', 'matchers', ['matcher/fruzzy', 'matcher/project_files'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [ '.git/', '*cache*', 'venv/'])
