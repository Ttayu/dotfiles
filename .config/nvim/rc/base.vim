" file eoncoding
set encoding=utf-8
scriptencoding utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読みなす
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" clip board
set clipboard+=unnamedplus

" 行数の表示
set number
" 行数の相対位置の表示
set relativenumber
" 現在の行と列を強調
set cursorline
set cursorcolumn
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを表示
set laststatus=2
" コマンドラインの補完
set wildmenu
set wildmode=list:longest
" カーソル位置が画面端から数字分内側に来るように自動でスクロールする
set scrolloff=3
" 縦分割の際に右に表示する
set splitright

" タブ，インデント幅
set tabstop=2
set shiftwidth=2
set softtabstop=0
set shiftround
" タブ文字を半角スペースに
set expandtab
" 1つ前の行に基づいてインデント
set smartindent
set autoindent

" 検索文字列が小文字の場合は大小文字区別なく検索
set ignorecase
" 検索に大文字が含まれている場合は区別して検索
set smartcase
" インクリメントサーチ
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライトを表示
set hlsearch

" preview window のサイズを固定
set previewheight=2

" {{{}}}で折りたたむ
set foldmethod=marker

" terminal
tnoremap <Esc> <C-\><C-n>
