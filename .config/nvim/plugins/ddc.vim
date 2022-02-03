call ddc#custom#patch_global('sources', ['nvim-lsp', 'around', 'file'])
call ddc#custom#patch_global('sourceOptions', {
  \ '_': {
  \   'ignoreCase': v:true,
  \   'minAutoCompleteLength': 2,
  \   'matchers': ['matcher_fuzzy'],
  \   'sorters': ['sorter_fuzzy'],
  \   'converters': ['converter_fuzzy'],
  \ },
  \ 'necovim': {'mark': 'vim'},
  \ 'cmdline': {
  \   'mark': 'cmdline',
  \   'minAutoCompleteLength': 1000,
  \   'forceCompletionPattern': '\S/\S*',
  \ },
  \ 'cmdline-history': {'mark': 'history'},
  \ 'around': {
  \   'mark': 'A',
  \ },
  \ 'nvim-lsp': {
  \   'mark': 'lsp',
  \   'minAutoCompleteLength': 0,
  \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
  \ },
  \ 'file': {
  \   'mark': 'F',
  \   'minAutoCompleteLength': 1000,
  \   'isVolatile': v:true,
  \   'forceCompletionPattern': '\S/\S*',
  \ },
  \ })
call ddc#custom#patch_filetype(
  \ ['help', 'markdown', 'gitcommit', 'toml'], 'sources',
  \ ['around', 'file']
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

call ddc#custom#patch_global('completionMenu', 'pum.vim')
inoremap <silent><expr> <C-j> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<Down>'
inoremap <silent><expr> <C-k> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<Up>'
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <silent><expr> <C-Space>  ddc#map#extend()

nnoremap :       <Cmd>call CommandlinePre()<CR>:
nnoremap ;       <Cmd>call CommandlinePre()<CR>:

let s:prev_buffer_config = {}
function! CommandlinePre() abort
  " Note: It disables default command line completion!
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  cnoremap <silent><expr> <C-j> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<Down>'
  cnoremap <silent><expr> <C-k> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<Up>'
  cnoremap <silent><expr> <C-Space>  ddc#map#extend()

  " Overwrite sources
  if s:prev_buffer_config ==# ddc#custom#get_buffer()
   let s:prev_buffer_config = {}
  endif

  call ddc#custom#patch_buffer('sources',
          \ ['cmdline', 'cmdline-history', 'around'])
  call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#]*')

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()

  " Enable command line completion
  call ddc#enable_cmdline_completion()
  call ddc#enable()
endfunction
function! CommandlinePost() abort
  " Restore sources
  call ddc#custom#set_buffer(s:prev_buffer_config)
  cunmap <C-j>
  cunmap <C-k>
  cunmap <C-Space>
endfunction

call ddc#enable()
