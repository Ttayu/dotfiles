: "mise settings" && {
  eval "$(~/.local/bin/mise activate zsh)"
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
    if command_exists nvidia-smi; then
      gkill() {
        local pid
        pid=$(nvidia-smi | awk '/ C / {print $3}' | xargs -r ps -o user:20,pid,command, | grep $USER | fzf -m | awk '{print $2}')
        if [ "x$pid" != "x" ]
        then
          kill -KILL $pid
        fi
      }
    fi
}
