scriptencoding utf-8
autocmd TabEnter,CursorHold,FocusGained <buffer>
      \ call ddu#ui#do_action('checkItems')
augroup DduFilerSettings
  autocmd!
  autocmd FileType ddu-filer call s:ddu_filer_settings()
augroup END

function! s:ddu_filer_settings() abort
  nnoremap <buffer> i
        \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> *
        \ <Cmd>call ddu#ui#do_action('toggleAllItems')<CR>
  nnoremap <buffer> a
        \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer> <Esc>
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer> o
        \ <Cmd>call ddu#ui#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer> O
        \ <Cmd>call ddu#ui#do_action('expandItem',
        \ {'maxLevel': -1})<CR>
  nnoremap <buffer> c
        \ <Cmd>call ddu#ui#multi_actions([
        \   ['itemAction', {'name': 'copy'}],
        \   ['clearSelectAllItems'],
        \ ])<CR>
  nnoremap <buffer> d
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'delete' })<CR>
  nnoremap <buffer> D
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'trash' })<CR>
  nnoremap <buffer> m
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'move' })<CR>
  nnoremap <buffer> r
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'rename' })<CR>
  nnoremap <buffer> !
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'executeSystem' })<CR>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#do_action('preview')<CR>
  nnoremap <buffer> P
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'paste' })<CR>
  nnoremap <buffer> K
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'newDirectory' })<CR>
  nnoremap <buffer> N
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'newFile' })<CR>
  nnoremap <buffer> ~
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'narrow', params: #{ path: expand('~') } })<CR>
  nnoremap <buffer> \
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'narrow', params: #{ path: getcwd() } })<CR>
  nnoremap <buffer> h
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ name: 'narrow', params: #{ path: '..' } })<CR>
  nnoremap <buffer> yy
        \ <Cmd>call ddu#ui#do_action('itemAction', 
        \ #{ name: 'yank'})<CR>
  nnoremap <buffer> I
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{
        \   name: 'narrow',
        \   params: #{
        \     path: fnamemodify(input('cwd: ', b:ddu_ui_filer_path, 'dir'), ':p')
        \   }
        \ })<CR>
  nnoremap <buffer> >
        \ <Cmd>call ddu#ui#do_action('updateOptions', #{
        \   sourceOptions: #{
        \     file: #{
        \       matchers: ToggleHidden('file'),
        \     },
        \   },
        \ })<CR>
  nnoremap <buffer> <C-l>
        \ <Cmd>call ddu#ui#do_action('checkItems')<CR>
  nnoremap <buffer><expr> <CR>
        \ ddu#ui#get_item()->get('isTree', v:false) ?
        \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'narrow' })<CR>" :
        \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'open' })<CR>"
  nnoremap <buffer><expr> l
        \ ddu#ui#get_item()->get('isTree', v:false) ?
        \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'narrow' })<CR>" :
        \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'open' })<CR>"
endfunction

function! ToggleHidden(name)
  let current = ddu#custom#get_current(b:ddu_ui_name)
  let source_options = get(current, 'sourceOptions', {})
  let source_options_name = get(source_options, a:name, {})
  let matchers = get(source_options_name, 'matchers', [])
  return empty(matchers) ? ['matcher_hidden'] : []
endfunction

call ddu#custom#patch_local('filer', {
      \   'ui': 'filer',
      \   'sources': [
      \     {
      \       'name': 'file',
      \       'params': {},
      \     },
      \   ],
      \   'sourceOptions': {
      \     '_': {
      \       'columns': ['icon_filename'],
      \     },
      \     'file': {
      \       'matchers': ['matcher_substring'],
      \       'sorters': ['sorter_alpha'],
      \       'converters': ['converter_hl_dir'],
      \     },
      \     'path_history': {
      \       'defaultAction': 'uiCd',
      \     },
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \   },
      \   'actionOptions': {
      \     'narrow': {
      \       'quit': v:false 
      \     },
      \   },
      \   'uiOptions': {
      \     'filer': {
      \       'toggle': v:true 
      \     },
      \   },
      \   'uiParams': {
      \     'filer': {
      \       'split': 'floating',
      \       'sort': 'filename',
      \       'sortTreesFirst': v:true,
      \       'toggle': v:true,
      \     },
      \   },
      \   'searchPath': expand("%:p"),
      \ })


call ddu#custom#action('kind', 'file', 'uiCd', { args -> UiCdAction(args) })
function! UiCdAction(args)
  const path = a:args.items[0].action.path
  const directory = path->isdirectory() ? path : path->fnamemodify(':h')

  call ddu#ui#do_action('itemAction',
        \ #{ name: 'narrow', params: #{ path: directory } })
endfunction
