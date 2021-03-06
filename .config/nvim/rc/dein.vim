scriptencoding utf-8
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim/dein')
  let s:toml      = g:rc_dir .'/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  let s:lsp_toml = g:rc_dir . '/dein_lsp.toml'
  let s:python_toml = g:rc_dir . '/dein_python.toml'
  let s:go_toml = g:rc_dir . '/dein_go.toml'
  let s:web_toml = g:rc_dir . '/dein_web.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#load_toml(s:lsp_toml, {'lazy': 1})
  call dein#load_toml(s:python_toml, {'lazy': 1})
  call dein#load_toml(s:go_toml, {'lazy': 1})
  call dein#load_toml(s:web_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
