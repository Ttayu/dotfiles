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

let g:dein#auto_recache = v:true
let g:dein#install_check_diff = v:true
let g:dein#types#git#enable_partial_clone = v:true

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim/dein')
  let s:toml      = g:rc_dir .'/dein.toml'
  let s:syntax_toml = g:rc_dir . '/dein_syntax.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  let s:ddc_toml = g:rc_dir . '/dein_ddc.toml'
  let s:ddu_toml = g:rc_dir . '/dein_ddu.toml'
  let s:lsp_toml = g:rc_dir . '/dein_lsp.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:syntax_toml, {'lazy': 1})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#load_toml(s:ddc_toml, {'lazy': 1})
  call dein#load_toml(s:ddu_toml, {'lazy': 1})
  call dein#load_toml(s:lsp_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
