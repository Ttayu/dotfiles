# fuzzy matching
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# Set completion methods. Execute in specified order
zstyle ':completion:*' completer \
  _oldlist _complete _match _history _ignored _approximate _prefix

# Select completion candidates from menu
zstyle ':completion:*:default' menu select=2
# Cache completion candidates
zstyle ':completion:*' use-cache yes
export WORDCHARS='*?_.[]~-&;!#$%^(){}<>' 

zmodload zsh/complist
# Color file completion candidates
LS_COLORS="${LS_COLORS}:ow=01;34"; export LS_COLORS
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

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
  # Replace only exact patterns (separated by surrounding characters)
  body="${body//\$scheme = \(scp\|sftp\)/\$scheme = (scp|sftp|oil-ssh)}"
  body="${body//\(http\(\|s\)\|\(\|s\)ftp\|scp\|gopher\)/(http(|s)|(|s)ftp|scp|gopher|oil-ssh)}"
  functions[_urls]="$body"
}
