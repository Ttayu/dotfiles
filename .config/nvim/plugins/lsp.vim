let s:pyls_path = fnamemodify(g:python3_host_prog, ':h') . '/'. 'pyls'
let s:pyls_config = {'pyls': {'plugins': {
      \   'pycodestyle': {'enabled': v:false},
      \   'mccabe': {'enabled': v:false},
      \   'pyflakes': {'enabled': v:false},
      \   'pydocstyle': {'enabled': v:false},
      \   'pylint': {'enabled': v:false},
      \   'flake8': {'enabled': v:false},
      \   'rope_completion': {'enabled': v:false},
      \   'yapf': {'enabled': v:false},
      \     'jedi' : {'extra_paths' : [] },
      \     'jedi_completion'     : { 'enabled': v:true, 'include_params': v:true },
      \     'jedi_definition'     : { 'enabled': v:true, 'follow_imports': v:true, 'follow_builtin_imports': v:true },
      \     'jedi_hover'          : { 'enabled': v:true },
      \     'jedi_references'     : { 'enabled': v:true },
      \     'jedi_signature_help' : { 'enabled': v:true },
      \     'jedi_symbols'        : { 'enabled': v:true },
      \ }}}
if executable(s:pyls_path)
  augroup LspPython
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->[expand(s:pyls_path)]},
          \ 'allowlist': ['python'],
          \ 'workspace_config': s:pyls_config,
          \ })
  augroup END
endif

if executable('gopls')
  augroup LspGo
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'golang',
          \ 'cmd': {server_info->['gopls']},
          \ 'allowlist': ['go'],
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
          \ 'allowlist': ['typescript', 'typescript.tsx', 'typescriptreact'],
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
          \ 'allowlist': ['javascript', 'javascript.jsx', 'javascriptreact'],
          \  })
  augroup END
endif

if executable('docker-langserver')
  augroup LspDocker
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'docker-langserver',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
          \ 'allowlist': ['dockerfile'],
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
        \ 'allowlist': ['javascript', 'javascript.jsx'],
        \ })
  augroup END
endif

if executable('ccls')
  augroup LspCpp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
         \ 'name': 'ccls',
         \ 'cmd': {server_info->['ccls']},
         \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
         \ 'initialization_options': {
         \    'highlight': {'lsRanges': v:true},
         \  },
         \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cc', 'cuda'],
         \ })
  augroup END
endif

if executable('rls')
  augroup LspRust
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'rls',
          \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
          \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
          \ 'allowlist': ['rust'],
          \ })
  augroup END
endif

if executable('java') && filereadable(expand('~/.lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'))
  augroup LspJava
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'),
        \     '-configuration',
        \     expand('~/lsp/eclipse.jdt.ls/config_mac'),
        \     '-data',
        \     getcwd()
        \ ]},
        \ 'allowlist': ['java'],
        \ })
  augroup END
endif


if executable('kotlin') && executable(expand('~/.lsp/kotlin-language-server/server/bin/kotlin-language-server'))
  augroup LspKotlin
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': {server_info->[
        \     &shell,
        \     &shellcmdflag,
        \     expand('~/lsp/kotlin-language-server/server/bin/kotlin-language-server')
        \ ]},
        \ 'allowlist': ['kotlin']
        \ })
  augroup END
endif

if executable('R') && executable(expand('~/.lsp/R/languageserver/libs/languageserver.so'))
  augroup LspR
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'R-language-server',
        \ 'cmd': {server_info->[
        \     'R',
        \     '--slave',
        \     '-e',
        \     'languageserver::run()',
        \ ]},
        \ 'allowlist': ['r']
        \ })
  augroup END
endif

" use ale instead of lsp
let g:lsp_diagnostics_enabled = 0
let g:lsp_async_completion = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_virtual_text_enabled = 0
let g:lsp_diagnostics_float_delay = 100

nnoremap [lsp] <Nop>
nmap <Leader>l [lsp]
inoremap [lsp] <Nop>
imap <Leader>l [lsp]
nnoremap [lsp]a :<C-u>LspCodeAction<CR>
nnoremap [lsp]c :<C-u>LspDeclaration<CR>
nnoremap [lsp]d :<C-u>LspDefinition<CR>
nnoremap [lsp]f :<C-u>LspDocumentFormat<CR>
nnoremap [lsp]s :<C-u>LspDocumentSymbol<CR>
nnoremap [lsp]h :<C-u>LspHover<CR>
inoremap [lsp]h <Esc>:<C-u>LspSignatureHelp<CR><Insert>
nnoremap [lsp]i :<C-u>LspImplementation<CR>
nnoremap [lsp]p :<C-u>LspPeekDefinition<CR>
nnoremap [lsp]x :<C-u>LspReferences<CR>
nnoremap [lsp]m :<C-u>LspStatus<CR>
nnoremap [lsp]r :<C-u>LspRename<CR>
nnoremap [lsp]t :<C-u>LspTypeDefinition<CR>
