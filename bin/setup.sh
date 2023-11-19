#!/usr/bin/env zsh
set -euo pipefail

DOT_DIRECTORY="${HOME}/dotfiles"
source ${DOT_DIRECTORY}/bin/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
}

# : "install brew" && {
#   if ! command_exists brew; then
#     info "installing brew..."
#     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#   else
#     warn "brew is already installed"
#   fi
# }

if [ $(uname) = 'Darwin' ]; then
  : "install tmux-256color on macOS" && {
    if ! command_exists /usr/local/opt/ncurses/bin/infocmp ; then
      info "installing ncurses..."
      brew install ncurses
    fi
    tic -xe tmux-256color ${DOT_DIRECTORY}/tmux-256color.info
  }
fi

# : "install other packages by brew" && {
#   if [ $(uname) = 'Darwin' ]; then
#     brew bundle --file ${DOT_DIRECTORY}/Brewfile.macos
#   elif [ $(uname) = 'Linux' ]; then
#     brew bundle --file ${DOT_DIRECTORY}/Brewfile.linux
#   fi
# }

: "install asdf" && {
  ASDF_DIR=$HOME/.asdf
  if [ ! -e $ASDF_DIR ]; then
    info "installing asdf"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
  else
    warn "asdf is already installed"
  fi
}

: "install other packages by asdf" && {
  PACKAGES=(bat fd ripgrep delta exa deno neovim)
  asdf plugin add python
  for p in $PACKAGES; do
    asdf plugin add $p
    asdf install $p latest
    asdf global $p latest
  done
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

# : "install poetry" && {
#   if ! command_exists poetry; then
#     info "installing poetry..."
#     curl -sSL https://install.python-poetry.org | python3 -
#     poetry config virtualenvs.in-project true
#   else
#     warn "poetry is already installed"
#   fi
# }

: "setup sheldon" && {
  local SHELDON_DIR=$HOME/.config/sheldon
  if [ ! -e $SHELDON_DIR ]; then
    info "setup sheldon"
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
      | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
    mkdir -p $SHELDON_DIR && \
      ln -s ~/dotfiles/zsh/sheldon.plugins.toml $SHELDON_DIR/plugins.toml
  else
      warn "sheldon is already installed"
  fi
}

: "set git config" && {
  git config --global core.excludesFile ./.gitignore_global
  git config --global commit.template ~/.commit_template
}

ok "Complete!"
