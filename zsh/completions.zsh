# fuzzy matching
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
# zstyle ':completion:*' matcher-list '' \
#   'm:{a-z\-}={A-Z\_}' \
#   'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
#   'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' matcher-list \
  '' \
  'm:{a-z}={A-Z}' \
  'l:|=* r:|=*'

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

_fuzzy_path_complete() {
  emulate -L zsh
  setopt localoptions noshwordsplit pipefail
  local left token prefix query base relbase
  local all filtered selected insert
  local count
  local global_all global_filtered global_count
  left=$LBUFFER
  token=${left##* }
  if [[ $token == */* ]]; then
    prefix=${token%/*}/
    query=${token##*/}
  else
    prefix=""
    query=$token
  fi
  base=${prefix:-.}
  relbase=${base%/}
  _fd_candidates() {
    local search_base=$1
    {
      fd . "$search_base" \
        --type d \
        --hidden \
        --exclude .git \
        --exclude node_modules \
        --exclude .venv \
        --exclude __pycache__
      fd . "$search_base" \
        --type f \
        --hidden \
        --exclude .git \
        --exclude node_modules \
        --exclude .venv \
        --exclude __pycache__
    }
  }
  _count_lines() {
    sed '/^$/d' | wc -l | tr -d ' '
  }
  if [[ -d $base ]]; then
    all=$(_fd_candidates "$base" | sed "s#^${relbase}/##")
    if [[ -n $query ]]; then
      filtered=$(printf '%s\n' "$all" | fzf --scheme=path --filter="$query")
    else
      filtered=$all
    fi
    count=$(printf '%s\n' "$filtered" | _count_lines)
  else
    count=0
    filtered=""
    all=""
  fi
  if [[ $count -eq 0 ]]; then
    global_all=$(_fd_candidates ".")
    if [[ -n $query ]]; then
      global_filtered=$(printf '%s\n' "$global_all" | fzf --scheme=path --filter="$query")
    else
      global_filtered=$global_all
    fi
    global_count=$(printf '%s\n' "$global_filtered" | _count_lines)
    case $global_count in
      0)
        zle -M "no match"
        return 0
        ;;
      1)
        selected=$global_filtered
        ;;
      *)
        selected=$(
          printf '%s\n' "$global_filtered" | \
            fzf \
              --scheme=path \
              --query="$query" \
              --select-1 \
              --exit-0 \
              --height=40% \
              --reverse
        )
        [[ -n $selected ]] || return 0
        ;;
    esac
    insert=$selected
    [[ -d $insert ]] && insert="${insert}/"
    LBUFFER="${left%$token}$insert"
    zle redisplay
    return 0
  fi
  case $count in
    1)
      selected=$filtered
      ;;
    *)
      selected=$(
        printf '%s\n' "$filtered" | \
          fzf \
            --scheme=path \
            --query="$query" \
            --select-1 \
            --exit-0 \
            --height=40% \
            --reverse
      )
      [[ -n $selected ]] || return 0
      ;;
  esac
  if [[ $relbase == "." || -z $relbase ]]; then
    insert=$selected
  else
    insert="${relbase}/${selected}"
  fi
  [[ -d $insert ]] && insert="${insert}/"
  LBUFFER="${left%$token}$insert"
  zle redisplay
}
zle -N fuzzy-path-complete _fuzzy_path_complete
bindkey '^G' fuzzy-path-complete
