#!/usr/bin/env zsh
set -euo pipefail

DOT_DIRECTORY="${HOME}/dotfiles"
DOT_CONFIG_DIRECTORY=".config"

source ${DOT_DIRECTORY}/bin/echos.sh

info "link home directory dotfiles"
cd ${DOT_DIRECTORY}

for f in .??*
do
  # 無視したいファイルやディレクトリ
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".git" ] && continue
  [ "$f" = ".config" ] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

for f in ${DOT_CONFIG_DIRECTORY}/*
do
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${DOT_CONFIG_DIRECTORY}
done

ok "linked dotfiles complete!"
