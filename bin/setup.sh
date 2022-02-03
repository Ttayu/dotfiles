#!/usr/bin/env zsh
set -euo pipefail

DOT_DIRECTORY="${HOME}/dotfiles"
source ${DOT_DIRECTORY}/bin/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
}

: "install brew" && {
  if ! command_exists brew; then
    info "installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    warn "brew is already installed"
  fi
}

if [ $(uname) = 'Darwin' ]; then
  : "install tmux-256color on macOS" && {
    if ! command_exists /usr/local/opt/ncurses/bin/infocmp ; then
      info "installing ncurses..."
      brew install ncurses
    fi
      tic -xe tmux-256color ${DOT_DIRECTORY}/tmux-256color.info
    }
fi

: "install other packages by brew" && {
  if [ $(uname) = 'Darwin' ]; then
    brew bundle --file ${DOT_DIRECTORY}/Brewfile.macos
  elif [ $(uname) = 'Linux' ]; then
    brew bundle --file ${DOT_DIRECTORY}/Brewfile.linux
  fi
}

: "install tmux plugins manager" && {
  TPM_DIR=$HOME/.tmux/plugins/tpm
  if [ ! -e $TPM_DIR ]; then
    info "installing tmux plugins manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  else
    warn "tpm is already installed"
  fi
}

: "install poetry" && {
  if ! command_exists poetry; then
    info "installing poetry..."
    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3
    poetry config virtualenvs.in-project true
  else
    warn "poetry is already installed"
  fi
}

: "install zinit" && {
  ZINIT_DIR=$HOME/.zinit
  if [ ! -e $ZINIT_DIR ]; then
    info "installing zinit..."
    sh -c "$(curl -fsSL https://git.io/zinit-install)"
  else
    warn "zinit is already installed"
  fi
}

: "set git config" && {
  git config --global core.excludesFile ./.gitignore_global
}

ok "Complete!"