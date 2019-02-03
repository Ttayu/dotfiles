let g:neosnippet#snippets_directory=['~/.config/nvim/snippets']
let g:neosnippet#snippets_directory+=['~/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets']
let g:neosnippet#snippets_directory+=['~/.cache/dein/repos/github.com/honza/vim-snippets/snippets']
" parameter expansion
let g:neosnippet#enable_completed_snippet = 1
" no skip comma
" let g:neosnippet#enable_optional_arguments = 0
"補完候補選択時は<TAB>で候補移動snipppet時は<TAB>で次の入力先へ
imap <expr><TAB> pumvisible() ? "\<C-n>" :
     \ neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

imap <expr><S-TAB> pumvisible() ? "\<C-p>" :
     \ neosnippet#expandable_or_jumpable() ?
     \   "\<Plug>(neosnippet_expand_or_jump)" : "\<S-TAB>"

smap <expr><TAB> pumvisible() ? "\<C-n>" :
     \ neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><S-TAB> pumvisible() ? "\<C-p>" :
     \ neosnippet#expandable_or_jumpable() ?
     \   "\<Plug>(neosnippet_expand_or_jump)" : "\<S-TAB>"
" Enterで補完を確定
imap <expr><CR>
     \ (pumvisible() && neosnippet#expandable()) ? "\<Plug>(neosnippet_expand)" : "\<CR>"
" For conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
