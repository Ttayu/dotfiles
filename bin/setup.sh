#!/usr/bin/env zsh
set -euo pipefail

DOT_DIRECTORY="${HOME}/dotfiles"
source ${DOT_DIRECTORY}/bin/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
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

: "install mise" && {
  MISE_BIN=$HOME/.local/bin/mise
  if [ ! -e $MISE_BIN ]; then
    info "installing mise"
    curl https://mise.jdx.dev/install.sh | sh 
    eval "$(~/.local/bin/mise activate zsh)"
    mise completion zsh  > /usr/local/share/zsh/site-functions/_mise 
  else
    warn "mise is already installed"
  fi
}

: "install other packages by mise" && {
  info "installing packages by mise"
  PACKAGES=(bat delta deno exa fd nodejs python pdm ripgrep)
  for p in $PACKAGES; do
    mise use --global -y $p@latest
  done
  PACKAGES=(neovim rust)
  for p in $PACKAGES; do
    mise use --global -y $p@nightly
  done
}

: "setup pdm" && {
  pdm --pep582 zsh >> ~/.zprofile
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
