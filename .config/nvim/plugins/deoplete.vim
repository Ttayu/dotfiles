scriptencoding utf-8
inoremap <expr><C-g> deoplete#refresh()
inoremap <expr><C-e> deoplete#cancel_popup()

" close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
endfunction

call deoplete#custom#source('_', 'matchers',
      \ ['matcher_full_fuzzy', 'matcher_length'])

call deoplete#custom#source('look', 'filetypes', ['help', 'gitcommit'])
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer', 'tag']})

call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])
call deoplete#custom#source('_', 'min_pattern_length', 0)
call deoplete#custom#source('neosnippet', 'min_pattern_length', 2)
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'matcher_length',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_info',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_]\k*\(?',
      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
      \ })

call deoplete#custom#option({
      \ 'auto_complete_delay': 10,
      \ 'auto_refresh_delay': 10,
      \ 'camel_case': v:true,
      \ 'ignore_case': v:true,
      \ 'smart_case': v:true,
      \ 'skip_multibyte': v:true,
      \ 'prev_completion_mode': 'length',
      \ })

set completeopt-=preview

call deoplete#enable()
