let g:neosnippet#snippets_directory=['~/.config/nvim/snippets']
let g:neosnippet#snippets_directory+=['~/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets']
let g:neosnippet#snippets_directory+=['~/.cache/dein/repos/github.com/honza/vim-snippets/snippets']

imap <Leader>n <Plug>(neosnippet_expand_or_jump)
smap <Leader>n <Plug>(neosnippet_expand_or_jump)
xmap <Leader>n <Plug>(neosnippet_expand_or_jump)

"補完候補選択時は<TAB>で候補移動snipppet時は<TAB>で次の入力先へ
inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
