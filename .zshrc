function command_exists() {
  type "$1" &> /dev/null ;
}

: "Added by Zinit's installer" && {
  ### Added by Zinit's installer
  if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
      print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
      print -P "%F{160}▓▒░ The clone has failed.%f"
  fi
  source "$HOME/.zinit/bin/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
}

: "install Zinit plugin" && {
  zinit wait'0a' lucid nocompletions for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

  zinit light 'chrissicool/zsh-256color'
  zinit light iboyperson/pastel

  # Binary release in archive, from GitHub-releases page.
  # After automatic unpacking it provides program "fzf".
  zinit ice from"gh-r" as"program"
  zinit load junegunn/fzf-bin

  zinit ice pick"shell/completion.zsh" src"shell/key-bindings.zsh"
  zinit load junegunn/fzf

  # Helps you with cd. Alternative to autojump.
  zinit ice wait lucid atload"zicompinit; zicdreplay" blockf 
  zinit light b4b4r07/enhancd
  export ENHANCD_COMPLETION_BEHAVIOR=list

  # Divide terminal
  zinit light greymd/tmux-xpanes

  # Auto close and delete matching delimiters
  zinit ice wait lucid
  zinit load hlissner/zsh-autopair

  zinit light davidparsson/zsh-pyenv-lazy
  zinit light shihyuho/zsh-jenv-lazy

  zinit ice wait'1' as"completion" lucid
  zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
}

: "history settings" && {
  HISTFILE=$HOME/.zsh_history
  HISTSIZE=100000
  SAVEHIST=100000
  setopt share_history
  # 重複を記録しない
  setopt hist_ignore_dups
  setopt hist_ignore_space
  setopt hist_reduce_blanks
}

: "common aliases" && {
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    alias ls="ls -G"
  else
    alias ls="ls --color"
  fi
  alias ll="ls -a"
  alias l="ls -la"
  alias t="tmux"
  alias tl="tmux ls"
  alias ta="tmux attach"
  alias tk="tmux kill-session"
  alias td="tmux detach"
  alias vim="nvim"
  alias v="nvim"
  alias vz="nvim ~/.zshrc"
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias g='git'
  alias ga='git add'
  alias gd='git diff'
  alias gs='git status'
  alias gp='git push'
  alias gb='git branch'
  alias gco='git checkout'
  alias gf='git fetch'
  alias gc='git commit -m'
  alias h='cd ~'
  alias cn="cd ~/dotfiles/.config/nvim"
  alias vn="v ~/dotfiles/.config/nvim/init.vim"
  alias reload='exec $SHELL -l'
}

: "zsh settings" && {
  bindkey -e
  if [[ -f $HOME/.zfunc ]]; then
    mkdir $HOME/.zfunc
  fi
  fpath+=~/.zfunc # for poetry (python)
  # コマンドのオプションや引数を補完する
  autoload -Uz compinit && compinit

  export EDITOR=nvim
  bindkey '^[[Z' reverse-menu-complete
  bindkey "^[[A" history-search-backward
  bindkey "^[[B" history-search-forward
  bindkey "^P" history-search-backward
  bindkey "^N" history-search-forward
  # ctrl + <-/->
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word

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
  # 補完候補が複数あるときに一覧表示
  setopt auto_list
  # 補完候補が複数あるときに自動的に一覧表示
  setopt auto_menu
  setopt no_beep
  setopt nonomatch
  # 曖昧に補完する
  # m:{a-z}={A-Z}: 大文字と小文字を区別しない
  # r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完
  # 補完時に大文字小文字を区別しない
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*' 
  # 補完方法の設定．指定した順番に実行する
  zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix

  # ファイル補完候補に色を付ける
  zstyle ':completion:*:default' list-colors ""
  # 補完候補をメニューから選択
  zstyle ':completion:*:default' menu select=2
  # 補完候補をキャッシュ
  zstyle ':completion:*' use-cache yes
  export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>' 

  zmodload zsh/complist
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'j' vi-down-line-or-history
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char

  bindkey -M emacs "^[h" backward-char
  bindkey -M emacs "^[j" down-line-or-history
  bindkey -M emacs "^[k" up-line-or-history
  bindkey -M emacs "^[l" forward-char

  LS_COLORS="${LS_COLORS}:ow=01;34"; export LS_COLORS
  _ls_colors="ow=01;34"
  zstyle ':completion:*:default' list-colors "${(s.:.)_ls_colors}"
}

: "python settings" && {
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PATH="$HOME/.poetry/bin:$PATH"
}

: "golang settings" && {
  if command_exists go; then
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=$HOME/.config/go
    export GOROOT=$( go env GOROOT )
    export PATH=$GOPATH/bin:$PATH
  fi
}

: "rust settings" && {
  export PATH="$PATH:$HOME/.cargo/bin"
}

: "java/kotlin settings" && {
  # source "/Users/yuki-tana/.sdkman/bin/sdkman-init.sh"
  export ANDROID_HOME=$HOME/Library/Android/sdk
}

: "C++ settings" && {
  if command_exists llvm; then
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/llvm/lib"
    export CPPFLAGS="-I/usr/local/opt/llvm/include"
  fi
}

: "fzf settings" && {
  if [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
    export FZF_CTRL_T_COMMAND="rg --files --no-ignore --hidden --follow --glob '!.git/*'"
    export FZF_CTRL_T_OPTS="--preview 'bat  --color=always --style=header,grid --line-range :100 {}'"
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
    fkill() {
      local pid
      pid=$(ps -ax | sed 1d | fzf -m | awk '{print $1}')

      if [ "x$pid" != "x" ]
      then
        kill -KILL $pid
      fi
    }
}
