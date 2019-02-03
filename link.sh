#!/usr/local/bin/zsh
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_CONFIG_DIRECTORY=".config"

set -euo pipefail
source ${DOT_DIRECTORY}/lib/echos.sh

info "link home directory dotfiles"
cd ${DOT_DIRECTORY}

for f in .??*
do
  # 無視したいファイルやディレクトリ
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".git" ] && continue
  [ "$f" = ".config" ] && continue
  [ "$f" = "configstore" ] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

info "link .config directory dotfiles"
cd ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}
for file in `\find . -maxdepth 8 -type f`; do
  [ "$file" = "configstore" ] && continue
  dest=${HOME}/${DOT_CONFIG_DIRECTORY}/${file:2}
  if [ -e ${dest} ]; then
    warn "[warn] ${dest}: skipped (already exists)"
  else
    # 親directoryがない場合(-p)作成する
    mkdir -p ${dest%/*}
    # ./の2文字を削除するためにfile:2としている
    ln -snfv ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}/${file:2} ${dest}
  fi
done

ok "linked dotfiles complete!"
