let s:pyls_path = fnamemodify(g:python3_host_prog, ':h') . '/'. 'pyls'
if executable(s:pyls_path)
  augroup LspPython
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->[expand(s:pyls_path)]},
          \ 'whitelist': ['python'],
          \ })
  augroup END
endif

if executable('gopls')
  augroup LspGo
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'golang',
          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
  augroup END
endif

if executable('typescript-language-server')
  augroup LspTypeScript
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'typescript support using typescript-language-server',
          \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json')) },
          \ 'whitelist': ['typescript', 'typescript.tsx'],
          \  })
  augroup END
endif

if executable('typescript-language-server')
  augroup LspJavaScript
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'javascript support using typescript-language-server',
          \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json')) },
          \ 'whitelist': ['javascript', 'javascript.jsx'],
          \  })
  augroup END
endif

if executable('docker-langserver')
  augroup LspDocker
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'docker-langserver',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
          \ 'whitelist': ['dockerfile'],
          \ })
  augroup END
endif

if executable('flow')
  augroup LspFlow
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'flow',
        \ 'cmd': {server_info->['flow', 'lsp']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
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
