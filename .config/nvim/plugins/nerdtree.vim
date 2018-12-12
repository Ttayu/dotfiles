" 起動コマンド
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" ブックマークを表示
let g:NERDTreeShowBookmarks = 1

" ディレクトリ表示の設定
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" 親ディレクトリへ移動
let g:NERDTreeMapUpdir = ''

" ファイルを開いたらNERDTreeを閉じる
let g:NERDTreeQuitOnOpen = 1

" 隠しファイルを表示
let g:NERDTreeShowHidden = 1

" 非表示ファイル
let g:NERDTreeIgnore=['\.git$']

" NERDTreeを同時に閉じる
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
