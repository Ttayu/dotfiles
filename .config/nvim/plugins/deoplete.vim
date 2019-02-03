call deoplete#custom#source('_', 'matchers',
      \ ['matcher_fuzzy', 'matcher_length'])

call deoplete#custom#source('look', 'filetypes', ['help', 'gitcommit'])
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer', 'tag']})

call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])

call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'matcher_length',
      \ 'converter_truncate_abbr',
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

" " insert modeから抜けた時にpreviewを閉じる
autocmd InsertLeave * silent! pclose!

call deoplete#enable()
