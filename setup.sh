set -euo pipefail

source lib/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
}

: "install brew" && {
  if ! command_exists brew; then
    info "installing brew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    warn "brew is already installed"
  fi
}

: "install zsh by brew" && {
  BREW_ZSH_PATH="/usr/local/bin/zsh"
  if ! brew list | grep zsh &> /dev/null; then
    info "installing zsh..."
    brew install zsh zsh-completions
    sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells'
    chsh -s $(brew --prefix)/bin/zsh
  else
    warn "zsh is already installed"
  fi
}

: "install other packages by brew" && {
  packages=( neovim tmux fzf tree jq wget autojump direnv pyenv pipenv golang global)
  for package in ${packages[@]}; do
    if ! brew list | grep $package &> /dev/null; then
      info "installing ${package}..."
      brew install ${package}
    else
      warn "${package} is already installed"
    fi
  done
}
 
: "install zinit" && {
  ZINIT_DIR=$HOME/.zinit
  if [ ! -e $ZINIT_DIR ]; then
    info "installing zinit..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  else
    warn "zinit is already installed"
  fi
}

: "set git config" && {
  git config --global core.excludesFile ./.gitignore_global
}

ok "Complete!"
