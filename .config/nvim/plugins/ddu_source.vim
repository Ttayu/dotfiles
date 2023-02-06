scriptencoding utf-8

call ddu#custom#alias('source', 'file_rg', 'file_external')
call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'sourceOptions': {
      \     '_': {
      \       'ignoreCase': v:true,
      \       'matchers': ['matcher_substring'],
      \     },
      \     'file_old': {
      \       'matchers': [
      \         'matcher_fzf', 'matcher_relative', 'matcher_hidden',
      \       ],
      \     },
      \     'file_external': {
      \       'matchers': [
      \         'matcher_fzf', 'matcher_hidden',
      \       ],
      \     },
      \     'file_rec': {
      \       'matchers': [
      \         'matcher_fzf', 'matcher_hidden',
      \       ],
      \     },
      \     'dein': {
      \       'defaultAction': 'cd',
      \     },
      \     'line': {
      \       'matchers': [
      \         'matcher_kensaku',
      \       ],
      \     },
      \     'command_history': {
      \       'defaultAction': 'execute',
      \     },
      \   },
      \   'sourceParams': {
      \     'file_external': {
      \       'cmd': ['fd', '.', '-H', '-E', '*cache*', '-t', 'f', '-S', '-1m'],
      \     },
      \   },
      \   'uiParams': {
      \     'ff': {
      \       'split': 'floating',
      \       'filterSplitDirection': 'floating',
      \       'previewFloating': v:true,
      \     },
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \     'word': {
      \       'defaultAction': 'append',
      \     },
      \     'help': {
      \       'defaultAction': 'open',
      \     }, 
      \     'action': {
      \       'defaultAction': 'do',
      \     },
      \   }
      \ })
call ddu#custom#patch_local('files', {
      \   'uiParams': {
      \     'ff': {
      \       'split': 'floating',
      \     }
      \   },
      \ })
call ddu#custom#patch_global({
      \   'sourceParams': {
      \     'file_rg': {
      \       'cmd': ['rg', '--files', '--glob', '!.git',
      \               '--color', 'never', '--no-messages'],
      \       'updateItems': 50000,
      \     },
      \   }
      \ })
call ddu#custom#patch_global({
      \   'filterParams': {
      \     'matcher_substring': {
      \       'highlightMatched': 'Search',
      \     },
      \   }
      \ })
