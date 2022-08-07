typeset -U path PATH
bindkey -e
if [[ ! -d $HOME/.zfunc ]]; then
  mkdir $HOME/.zfunc
fi
fpath+=~/.zfunc # for poetry (python)
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
