HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

typeset -U path PATH
bindkey -e
if [[ ! -d $HOME/.zfunc ]]; then
  mkdir $HOME/.zfunc
fi
fpath+=~/.zfunc # for poetry (python)

setopt share_history
# 重複を記録しない
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
# ディレクトリ名の補完で末尾の/を自動的に付加
setopt auto_param_slash
# ファイル名の展開でディレクトリにマッチした場合末尾に/を付加
setopt mark_dirs
# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu
# 括弧の対応などを自動的に補完
setopt auto_param_keys
# ＝以降も補完がきく
setopt magic_equal_subst
# 語の途中でカーソル位置で補完
setopt complete_in_word
# cdを使わずに移動
setopt auto_cd
setopt auto_pushd
# 補完候補が複数あるときに一覧表示
setopt auto_list
# 補完候補が複数あるときに自動的に一覧表示
setopt auto_menu
setopt no_beep
setopt nonomatch
