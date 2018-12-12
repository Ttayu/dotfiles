augroup vimrc
  autocmd!
augroup END
if &compatible
  set nocompatible
endif
runtime rc/base.vim
runtime rc/map.vim
runtime rc/dein.vim
runtime rc/color.vim
