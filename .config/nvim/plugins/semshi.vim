scriptencoding utf-8
" f-strings と formatを併用すると変数の位置がおかしくなってしまうバグがある．
" https://github.com/numirias/semshi/issues/31
function MyCustomHighlights()
  hi semshiLocal           ctermfg=209 guifg=#673AB7
  hi semshiGlobal          ctermfg=214 guifg=#ffaf00
  hi semshiImported        ctermfg=255 guifg=#eeeeee
  hi semshiParameter       ctermfg=81  guifg=#dce775
  hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
  hi semshiFree            ctermfg=218 guifg=#ffafd7
  hi semshiBuiltin         ctermfg=207 guifg=#A1887F
  hi semshiSelf            ctermfg=249 guifg=#ffafd7
  hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
  hi semshiSelected      ctermfg=15 guifg=#ffffff guibg=bg cterm=bold,underline gui=bold,underline

  hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
  hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
endfunction
autocmd vimrc FileType python call MyCustomHighlights()

" 強調しないリスト
let g:semshi#excluded_hl_groups = ['local', 'attribute']
" ALEがあるので不要
let g:semshi#error_sign = v:false 
" カーソル下の単語も強調
let g:semshi#mark_selected_nodes = 2

" semshi用のプリフィックス
nnoremap [semshi] <Nop>
nmap <Leader>s [semshi]
nnoremap <silent> [semshi]r :Semshi rename<CR>

nnoremap <silent> [semshi]c :Semshi goto class next<CR>
nnoremap <silent> [semshi]C :Semshi goto class prev<CR>

nnoremap <silent> [semshi]f :Semshi goto function next<CR>
nnoremap <silent> [semshi]F :Semshi goto function prev<CR>

nnoremap <silent> [semshi]e :Semshi goto error<CR>
