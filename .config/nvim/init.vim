augroup vimrc
  autocmd!
augroup END
if &compatible
  set nocompatible
endif
let g:python3_host_prog = $HOME . '/.py3/.venv/bin/python'
runtime rc/base.vim
runtime rc/map.vim
runtime rc/dein.vim
runtime rc/color.vim
