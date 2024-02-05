call ddc#custom#patch_global('sources', ['file', 'lsp', 'around', 'neosnippet'])
call ddc#custom#patch_global('cmdlineSources',
      \ ['cmdline-history', 'input', 'file', 'around']
      \ )
call ddc#custom#patch_global('sourceOptions', {
  \ '_': {
  \   'ignoreCase': v:true,
  \   'minAutoCompleteLength': 2,
  \   'matchers': ['matcher_fuzzy'],
  \   'sorters': ['sorter_fuzzy'],
  \   'converters': ['converter_fuzzy', 'converter_truncate_abbr'],
  \ },
  \ 'necovim': {'mark': 'vim'},
  \ 'cmdline': {
  \   'mark': 'cmdline',
  \   'minAutoCompleteLength': 1000,
  \   'forceCompletionPattern': '\S/\S*',
  \   'dup': 'force',
  \ },
  \ 'nvim-lua': {
  \   'mark': 'lua',
  \   'minAutoCompleteLength': 0,
  \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
  \   'dup': 'force',
  \ },
  \ 'input': {
  \   'mark': 'input',
  \   'forceCompletionPattern': '\S/\S*',
  \   'isVolatile': v:true,
  \   'dup': 'force',
  \ },
  \ 'cmdline-history': {
  \   'mark': 'history',
  \   'sorters': [],
  \   'dup': 'force',
  \ },
  \ 'around': {
  \   'mark': 'A',
  \ },
  \ 'lsp': {
  \   'mark': 'lsp',
  \   'dup': 'keep',
  \   'keywordPattern': '\k+',
  \   'sorters': ['sorter_lsp-kind', 'sorter_fuzzy'],
  \   'minAutoCompleteLength': 0,
  \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
  \ },
  \ 'file': {
  \   'mark': 'F',
  \   'minAutoCompleteLength': 1000,
  \   'isVolatile': v:true,
  \   'forceCompletionPattern': '\S/\S*',
  \   'sorters': ['sorter_rank'],
  \ },
  \ 'neosnippet': {
  \   'mark': 'snippet',
  \   'dup': 'force',
  \ },
  \ })
call ddc#custom#patch_global('sourceParams', {
  \ 'lsp': {
  \   'enableResolveItem': v:true,
  \   'enableAdditionalTextEdit': v:true,
  \   'confirmBehavior': 'replace',
  \   'enableDisplayDetail': v:true,
  \ },
  \ })
call ddc#custom#patch_filetype(
  \ ['help', 'markdown', 'gitcommit', 'toml'], 'sources',
  \ ['around', 'file', 'neosnippet']
  \ )
call ddc#custom#patch_filetype(
      \ ['vim'], 'sources',
      \ ['file','lsp', 'necovim', 'around']
      \ )
call ddc#custom#patch_filetype(
      \ ['lua'], 'sources',
      \ ['file', 'lsp', 'nvim-lua', 'around']
      \ )
call ddc#custom#patch_filetype(['FineCmdlinePrompt'], {
     \ 'keywordPattern': '[0-9a-zA-Z_:#]*',
     \ 'sources': ['cmdline', 'cmdline-history', 'around'],
     \ 'specialBufferCompletion': v:true,
     \ })

" Use pum.vim
call ddc#custom#patch_global('autoCompleteEvents', [
  \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
  \ 'CmdlineEnter', 'CmdlineChanged',
  \ ])

call ddc#custom#patch_global('ui', 'pum')
inoremap <silent><expr> <C-j> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1, "loop")<CR>' : '<Down>'
inoremap <silent><expr> <C-k> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1, "loop")<CR>' : '<Up>'

inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <silent><expr> <C-Space>  ddc#map#manual_complete()
inoremap <silent><expr> <CR>
    \ pum#visible() ?
    \ (
    \   pum#complete_info().selected >= 0 ?
    \     '<Cmd>call pum#map#confirm()<CR>' :
    \     '<Cmd>call pum#map#cancel()<CR>' . v:lua.MPairs.completion_confirm()
    \ ) :
    \ v:lua.MPairs.completion_confirm()

nnoremap :       <Cmd>call CommandlinePre()<CR>:
nnoremap ;       <Cmd>call CommandlinePre()<CR>:

function! CommandlinePre() abort
  " Note: It disables default command line completion!
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  cnoremap <silent><expr> <C-j> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1, "loop")<CR>' : '<Down>'
  cnoremap <silent><expr> <C-k> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1, "loop")<CR>' : '<Up>'
  cnoremap <silent><expr> <C-Space>  ddc#map#manual_complete()
  cnoremap <expr> <CR> pum#visible() ?
        \ pum#complete_info()["selected"] != -1 ?
        \ '<Cmd>call pum#map#confirm()<CR>' :
        \ '<Cmd>call pum#map#cancel()<CR><CR>' : '<CR>'

  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  
    " Use zsh source for :! completion
  call ddc#custom#set_context_buffer({ ->
        \ getcmdline()->stridx('!') ==# 0 ? {
        \   'cmdlineSources': [
        \     'cmdline', 'cmdline-history', 'around',
        \   ],
        \ } : {} })

  call ddc#custom#patch_buffer('sourceOptions', #{
        \ _: #{
        \    keywordPattern: '[0-9a-zA-Z_:#]*',
        \   },
        \ })

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()

  " Enable command line completion
  call ddc#enable_cmdline_completion()
  call ddc#enable()
endfunction
function! CommandlinePost() abort
  silent! cunmap <buffer> <C-y>
  silent! cunmap <buffer> <C-e>
  silent! cunmap <buffer> <C-j>
  silent! cunmap <buffer> <C-k>
  silent! cunmap <buffer> <C-Space>
  silent! cunmap <buffer> <CR>

  " Restore sources
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif
endfunction

call ddc#enable()

call ddc#set_static_import_path()
