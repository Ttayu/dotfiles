: "enable zplug" && {
  # zplug
  source ~/.zplug/init.zsh
  zplug 'zplug/zplug', hook-build:'zplug --self-manage'
  # タスクを非同期で実行する
  zplug "mafredri/zsh-async"
  # theme
  # zplug "wfxr/spaceship-zsh-theme", use:spaceship.zsh, as:theme
  zplug "iboyperson/pastel", as:theme
  # 構文のハイライト compiniti以降に読み込む必要がある
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  # history関係
  zplug "zsh-users/zsh-history-substring-search", defer:3
  # タイプ補完
  zplug "zsh-users/zsh-autosuggestions"
  # gitのエイリアス
  zplug "plugins/git", from:oh-my-zsh, if:"which git 1>/dev/null"
  # 補完ファイル
  zplug "zsh-users/zsh-completions"
  # zplug "chrissicool/zsh-256color"
  # command line fuzzy finder
  zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"
  # tmux用の拡張
  zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
  # Ctrl-Rで履歴検索、Ctrl-Tでファイル名検索補完できる
  zplug "junegunn/fzf", use:shell/key-bindings.zsh
  # cd **[TAB], vim **[TAB]などでファイル名を補完できる
  zplug "junegunn/fzf", use:shell/completion.zsh
  # fzfでよく使う関数の詰め合わせ
  zplug "mollifier/anyframe"
  # ターミナルのディレクトリ移動を高速化する
  zplug "b4b4r07/enhancd", use:"init.sh"
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  # Then, source plugins and add commands to $PATH
  zplug load
}

: "history settings" && {
  HISTFILE=$HOME/.zsh_history
  HISTSIZE=10000
  SAVEHIST=10000
  setopt share_history
}

: "common aliases" && {
  alias ls="ls -G"
  alias ll="ls -a"
  alias l="ls -la"
  alias vim="nvim"
  alias v="vim"
  alias vz="vim ~/.zshrc"
  alias cn="cd ~/.config/nvim"
  alias vn="v ~/.config/nvim"
  alias reload='exec $SHELL -l'
}

: "zsh settings" && {
  # コマンドのオプションや引数を補完する
  autoload -Uz compinit && compinit

  bindkey "^[[A" history-search-backward
  bindkey "^[[B" history-search-forward
  bindkey "^P" history-search-backward
  bindkey "^N" history-search-forward
  # 重複を記録しない
  setopt hist_ignore_dups
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
  # 曖昧に補完する
  # m:{a-z}={A-Z}: 大文字と小文字を区別しない
  # r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完
  # 補完時に大文字小文字を区別しない
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*' 
  # 補完方法の設定．指定した順番に実行する
  zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix
  #ファイル補完候補に色を付ける
  zstyle ':completion:*' list-colors $PS_COLORS
}

: "wsl settings" && {
  if [ "$(uname)" = 'Linux' ]; then
    unsetopt BG_NICE
    export DISPLAY=localhost:0.0
  fi
}

: "python settings" && {
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval  "$(pipenv --completion)"
  export PIPENV_VENV_IN_PROJECT=true
}

: "golang settings" && {
  export GOPATH=$HOME/.config/go
  export GOROOT=$( go env GOROOT )
  export PATH=$GOPATH/bin:$PATH
}

: "javascript settings" && {
  export PATH="$PATH:`yarn global bin`"
}

: "fzf settings" && {
  # not use brew
  if [ "$(uname)" = 'Linux' ]; then
    export FZFPATH=$HOME/.fzf
    export PATH=$FZFPATH/bin:$PATH
  fi
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
}
