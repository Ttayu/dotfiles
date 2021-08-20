let g:lsp_settings = {
      \ 'jedi-language-server': {
      \   'disable': 0,
      \ },
      \}
" use ale instead of lsp
let g:lsp_diagnostics_enabled = 0
let g:lsp_async_completion = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_virtual_text_enabled = 0
let g:lsp_diagnostics_float_delay = 100

nnoremap [lsp] <Nop>
nmap <Leader>l [lsp]
nnoremap [lsp]a :<C-u>LspCodeAction<CR>
nnoremap [lsp]c :<C-u>LspDeclaration<CR>
nnoremap [lsp]d :<C-u>LspDefinition<CR>
nnoremap [lsp]f :<C-u>LspDocumentFormat<CR>
nnoremap [lsp]s :<C-u>LspDocumentSymbol<CR>
nnoremap [lsp]h :<C-u>LspHover<CR>
nnoremap [lsp]i :<C-u>LspImplementation<CR>
nnoremap [lsp]p :<C-u>LspPeekDefinition<CR>
nnoremap [lsp]x :<C-u>LspReferences<CR>
nnoremap [lsp]m :<C-u>LspStatus<CR>
nnoremap [lsp]r :<C-u>LspRename<CR>
nnoremap [lsp]t :<C-u>LspTypeDefinition<CR>
