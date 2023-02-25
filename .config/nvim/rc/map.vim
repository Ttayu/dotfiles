scriptencoding utf-8
" リーダー
let g:mapleader = ','
" sはclで代用できるため
nnoremap s <Nop>

" ファイルの分割
nnoremap <silent> ss :split<CR>
nnoremap <silent> sv :vsplit<CR>

"tab関連
nnoremap <silent> st :tabnew<CR>
nnoremap <silent> sp :w<CR>:tabprevious<CR>
nnoremap <silent> sn :w<CR>:tabnext<CR>
nnoremap <silent> sw :tabclose<CR>

" 行末移動
nmap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>

" コロンとセミコロンを入れ替え
noremap ; :
noremap : ;
inoremap ; :
inoremap : ;
cnoremap : ;
cnoremap ; :

" ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 行頭，行末移動
noremap H  ^
noremap L  $

" 括弧移動
noremap <Space>m %

" 折り返し行移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" jjで保存とエスケープ
inoremap <silent> jj <ESC>:<C-u>w<CR>

" insert modeで移動
" 元々は<BS>
inoremap <C-h> <Left>
" 元々は改行
inoremap <C-j> <Down>
" 元vimrcに属するautocmdを初期化々はマルチバイト文字を入力
inoremap <C-k> <Up>
" 元々はinsert modeを抜ける
inoremap <C-l> <Right>
inoremap <C-b> <BS>

" xやsではヤンクしない
nnoremap x "_x
nnoremap s "_s

" 全コピー
nnoremap <Space>y ggyG
" 全削除して貼り付け
nnoremap <Space>p gg"_dGp

" Ctrl+] で右にエスケープ
inoremap <C-]> <Esc><Right>

" カーソル下の単語をハイライトする
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" カーソル下の単語をハイライトしてから置換する
nmap # <Space><Space>;%s/<C-r>///g<Left><Left>

" Space + Enterでハイライト解除
nnoremap <silent> <Space><CR> :nohlsearch<CR><Esc>

" 行を移動
" Alt-k -> ˚
" Alt-j -> ∆
nnoremap <M-k> "zdd<Up>"zP
nnoremap <M-j> "zdd"zp

" 複数行を移動
" Alt-k -> ˚
" Alt-j -> ∆
vnoremap <M-k> "zx<Up>"zP`[V`]
vnoremap <M-j> "zx"zp`[V`]

xnoremap r <C-v>
nnoremap <C-l> <Cmd>redraw!<CR>

" terminal
nnoremap <Leader>t :vsplit<CR>:terminal<CR>:set nonumber<CR>:set norelativenumber<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>
" Switching windows in terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
" for reflesh terminal
" tnoremap <C-l> <C-\><C-n><C-w>l

" Command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-b> <BS>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>
cnoremap <C-d> <Del>
