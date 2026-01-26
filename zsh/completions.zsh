# fuzzy matching
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# 補完方法の設定．指定した順番に実行する
zstyle ':completion:*' completer \
  _oldlist _complete _match _history _ignored _approximate _prefix

# ファイル補完候補に色を付ける
zstyle ':completion:*:default' list-colors ""
# 補完候補をメニューから選択
zstyle ':completion:*:default' menu select=2
# 補完候補をキャッシュ
zstyle ':completion:*' use-cache yes
export WORDCHARS='*?_.[]~-&;!#$%^(){}<>' 

zmodload zsh/complist
LS_COLORS="${LS_COLORS}:ow=01;34"; export LS_COLORS
_ls_colors="ow=01;34"
zstyle ':completion:*:default' list-colors "${(s.:.)_ls_colors}"

# Override _vim_files to add oil-ssh
_vim_files() {
  case $PREFIX in
    (+*) _files -P './' $* && return 0 ;;
    ((scp|http(|s)|(|s)ftp|oil-ssh):*) _urls ;;
    (*) _files $* ;;
  esac
  case $PREFIX in
    (+) _message -e 'start at a given line (default: end of file)' ;;
    (+<1->) _message -e 'line number' ;;
  esac
}

# Rewrite _urls (close scope with anonymous function)
() {
  autoload +X _urls 2>/dev/null
  local body="$functions[_urls]"
  # 正確なパターンのみ置換 (前後の文字で区切る)
  body="${body//\$scheme = \(scp\|sftp\)/\$scheme = (scp|sftp|oil-ssh)}"
  body="${body//\(http\(\|s\)\|\(\|s\)ftp\|scp\|gopher\)/(http(|s)|(|s)ftp|scp|gopher|oil-ssh)}"
  functions[_urls]="$body"
}
