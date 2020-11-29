let g:neosnippet#snippets_directory=['~/.vim/snippets']

" parameter expansion
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_complete_done = 1
let g:neosnippet#expand_word_boundary = 1

inoremap <expr> <TAB> pumvisible() ? (complete_info().selected == -1 ? '<C-y><TAB>' : '<C-y>') : '<TAB>'
inoremap <expr> <TAB> pumvisible() ? (complete_info().selected == -1 ? '<C-y><TAB>' : '<C-y>') : '<TAB>'

imap <silent><expr><TAB> neosnippet#expandable_or_jumpable() ? 
     \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ?
     \  (complete_info().selected == -1 ? "<C-y><TAB>" : "<C-y>") : "\<TAB>"
smap <silent><expr><TAB> neosnippet#expandable_or_jumpable() ? 
     \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ?
     \  (complete_info().selected == -1 ? "<C-y><TAB>" : "<C-y>") : "\<TAB>"
xmap <silent><TAB> <Plug>(neosnippet_expand_target)

" For conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=
endif

" need to use hard tab for indentation in snippet file.
autocmd vimrc FileType neosnippet setlocal noexpandtab
