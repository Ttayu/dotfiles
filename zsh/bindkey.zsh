bindkey '^[[Z' reverse-menu-complete
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
# ctrl + <-/->
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M emacs "^[h" backward-char
bindkey -M emacs "^[j" down-line-or-history
bindkey -M emacs "^[k" up-line-or-history
bindkey -M emacs "^[l" forward-char
