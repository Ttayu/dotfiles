let s:pyls_path = fnamemodify(g:python3_host_prog, ':h') . '/'. 'pyls'
if (executable(s:pyls_path))
  augroup LspPython
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->[expand(s:pyls_path)]},
          \ 'whitelist': ['python'],
          \ })
  augroup END
endif

if (executable('bingo'))
  augroup LspGo
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'go-lang',
          \ 'cmd': {server_info->['bingo', '-disable-func-snippet', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
  augroup END
endif

nnoremap [lsp] <Nop>
nmap <Leader>l [lsp]
nnoremap [lsp]a :<C-u>LspCodeAction<CR>
nnoremap [lsp]c :<C-u>LspDeclaration<CR>
nnoremap [lsp]d :<C-u>LspDefinition<CR>
nnoremap [lsp]f :<C-u>LspDocumentFormat<CR>
nnoremap [lsp]s :<C-u>LspDocumentSymbol<CR>
nnoremap [lsp]h :<C-u>LspHover<CR>
nnoremap [lsp]i :<C-u>LspImplementation<CR>
nnoremap [lsp]x :<C-u>LspReferences<CR>
nnoremap [lsp]m :<C-u>LspStatus<CR>
nnoremap [lsp]r :<C-u>LspRename<CR>
nnoremap [lsp]t :<C-u>LspTypeDefinition<CR>
