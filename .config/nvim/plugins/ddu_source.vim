scriptencoding utf-8

call ddu#custom#alias('files', 'source', 'file_rg', 'file_external')
call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'sourceOptions': {
      \     '_': {
      \       'ignoreCase': v:true,
      \       'matchers': ['matcher_substring'],
      \     },
      \     'file_old': {
      \       'matchers': [
      \         'matcher_relative', 'matcher_substring',
      \       ],
      \     'converters': ['converter_hl_dir'],
      \     },
      \     'file_external': {
      \       'matchers': [
      \         'matcher_fzf', 'matcher_hidden',
      \       ],
      \     'sorters': ['sorter_alpha'],
      \     'converters': ['converter_hl_dir'],
      \     },
      \     'file_rec': {
      \       'matchers': [
      \         'matcher_substring', 'matcher_hidden',
      \       ],
      \     'converters': ['converter_hl_dir'],
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
      \       'cmd': ['fd', '.', '-H', '-E', '.git', '-t', 'f', '-S', '-10m', '-X', 'grep', '-lI', '.'],
      \     },
      \     'rg': {
      \       'args': [
      \         '--ignore-case', '--column', '--no-heading',
      \         '--color', 'never',
      \       ],
      \     },
      \     'file_rg': {
      \       'cmd': ['rg', '--files', '--glob', '!.git',
      \               '--color', 'never', '--no-messages'],
      \       'updateItems': 50000,
      \     },
      \   },
      \   'uiParams': {
      \     'ff': {
      \       'split': 'floating',
      \       'filterSplitDirection': 'floating',
      \       'previewFloating': v:true,
      \       'previewSplit': 'no',
      \       'autoResize': v:true,
      \       'highlights': {
      \         'floating': 'Normal',
      \       },
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
      \     'prompt': {
      \       'defaultAction': 'execute',
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
      \   'filterParams': {
      \     'matcher_fzf': {
      \       'highlightMatched': 'Search',
      \     },
      \     'matcher_substring': {
      \       'highlightMatched': 'Search',
      \     },
      \     'matcher_kensaku': {
      \       'highlightMatched': 'Search',
      \     },
      \     'converter_hl_dir': {
      \       'hlGroup': ['Directory', 'Keyword'],
      \     },
      \   }
      \ })
