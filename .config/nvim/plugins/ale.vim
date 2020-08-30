scriptencoding utf-8
let g:ale_virtualenv_dir_names = [fnamemodify(g:python3_host_prog, ':h:h')]
" エラー行に表示するマーク
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" エラー表示の列を常時表示
let g:ale_sign_column_always = 1
" ファイルを開いたときにlint実行
let g:ale_lint_on_enter = 1
" ファイルを保存したときにlint実行
let g:ale_lint_on_save = 1
" ファイル保存した時にfix実行しない．
let g:ale_fix_on_save = 0
" 編集中のlintはしない
let g:ale_lint_on_text_changed = 'never'
" ステータスラインにどう表示するか
let g:ale_statusline_format = ['✖ %d', '⚠ %d', '⬥ ok']
" quickfixとloclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
" 指定していないlinterは利用しない
let g:ale_linters_explicit = 1

" 有効にするlinter
let g:ale_linters = {
      \ 'javascript': ['eslint', 'flow'],
      \ 'javascriptreact': ['eslint', 'flow'],
      \ 'typescript': ['eslint'],
      \ 'typescriptreact': ['eslint', 'tsserver'],
      \ 'python': ['flake8', 'mypy'],
      \ 'go': ['golangci-lint' ,'gobuild'],
      \ 'vim': ['vint'],
      \ 'rust': ['cargo'],
      \ 'kotlin': ['ktlint', 'languageserver'],
      \ 'r': ['lintr'],
      \ 'cpp': ['ccls'],
      \ }
" gometalinter
let g:ale_go_gometalinter_options = '--fast --vendor --disable-all --enable=golint --enable=vet --enable=goimports --enable=errcheck --enable=goconst --enable=goimports --enable=staticcheck'
" blackの最大長に合わせる
let g:ale_python_flake8_options = ' --max-line-length=88'
" 型情報のないパッケージは無視する
let g:ale_python_mypy_options = '--ignore-missing-imports'
" pipでインストールしたいくつかのモジュールは明示的に指定しないと動かない
let g:ale_vim_vint_executable = fnamemodify(g:python3_host_prog, ':h') . '/vint'
let g:ale_kotlin_languageserver_executable = $HOME . '/lsp/kotlin-language-server/server/bin/kotlin-language-server'

" 有効にするFixer
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'javascriptreact': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ 'html': ['prettier'],
      \ 'css': ['prettier'],
      \ 'python': ['autopep8', 'black', 'isort'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'json': ['jq', 'prettier'],
      \ 'rust': ['rustfmt'],
      \ 'r': ['styler']
      \ }
let g:ale_javascript_prettier_use_local_config = 1

" ALE用プレフィックス
nnoremap [ale] <Nop>
nmap <Leader>a [ale]
" エラー行にジャンプ
nmap <silent> [ale]E <Plug>(ale_previous)
nmap <silent> [ale]e <Plug>(ale_next)
" Lintを実行
nmap <silent> [ale]l <Plug>(ale_lint)
" Fixを実行
nmap <silent> [ale]f <Plug>(ale_fix)
