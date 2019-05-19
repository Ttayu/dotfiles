let g:neosnippet#snippets_directory=['~/.config/nvim/snippets']
let g:neosnippet#snippets_directory+=['~/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets']
let g:neosnippet#snippets_directory+=['~/.cache/dein/repos/github.com/honza/vim-snippets/snippets']
" parameter expansion
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1

" no skip comma
" let g:neosnippet#enable_optional_arguments = 0

imap <silent>L <Plug>(neosnippet_jump_or_expand)
smap <silent>L <Plug>(neosnippet_jump_or_expand)
xmap <silent>L <Plug>(neosnippet_expand_target)

" For conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
