scriptencoding utf-8

nnoremap [ddu] <Nop>
nmap <Leader>d [ddu]
nnoremap <silent> [ddu]v <Cmd>Ddu
      \ -name=files file_external
      \ -source-param-path='`fnamemodify($MYVIMRC, ':h')`'<CR>
nnoremap <silent> [ddu]p
      \ <Cmd>Ddu -name=files file_external
      \ -sync -ui-param-displaySourceName=short<CR>
nnoremap <silent> [ddu]o
      \ <Cmd>Ddu -name=files file_point file_old
      \ `finddir('.git', ';') != '' ? 'file_external' : 'file_rec'`
      \ -sync -ui-param-displaySourceName=short<CR>
nnoremap <silent> [ddu]b
      \ <Cmd>Ddu buffer<CR>
nnoremap <silent> / <Cmd>Ddu
      \ -name=search line -resume=v:false
      \ -ui-param-startFilter<CR>
nnoremap <silent> * <Cmd>Ddu
      \ -name=search line -resume=v:false -input=`expand('<cword>')`
      \ -ui-param-startFilter=v:false<CR>
nnoremap <silent> [ddu]g <Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -ui-param-ignoreEmpty
      \ -source-param-input=`input('Pattern: ')`<CR>
nnoremap <silent> [ddu]n <Cmd>Ddu
      \ -name=search -resume
      \ -ui-param-startFilter=v:false<CR>
nnoremap <silent> [ddu]r <Cmd>Ddu
      \ -name=register register
      \ -ui-param-autoResize<CR>
nnoremap <silent> [ddu]h  <Cmd>Ddu
      \ -name=help help
      \ -ui-param-startFilter<CR>
xnoremap <expr><silent> ,dr (mode() ==# 'V' ? '"_R<Esc>' : '"_d') ..
      \ '<Cmd>Ddu -name=register register
      \  -source-option-defaultAction=insert -ui-param-autoResize<CR>'
nnoremap <silent> sg <Cmd>Ddu
      \ dein<CR>
nnoremap <silent> [ddu]t <Cmd>Ddu
      \ command_history -input=''<CR>
" Insert filename
inoremap <C-f> <Cmd>call ddu#start(#{
      \   name: 'file',
      \   ui: 'ff',
      \   input: '.'->getline()[: '.'->col() - 1]->matchstr('\f*$'),
      \   sources: [
      \     #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
      \   ],
      \   uiParams: #{
      \     ff: #{
      \       startFilter: v:true,
      \       replaceCol: '.'->getline()[: '.'->col() - 1]->match('\f*$') + 1,
      \     },
      \   },
      \ })<CR>
