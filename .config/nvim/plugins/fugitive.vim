nnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]
nnoremap [fugitive]s :<C-u>Git status<CR>
nnoremap [fugitive]c :<C-u>Git commit<CR>
nnoremap [fugitive]C :<C-u>Git commit --amend<CR>
nnoremap [fugitive]b :<C-u>Git blame<CR>
nnoremap [fugitive]a :<C-u>Git write<CR>
nnoremap [fugitive]d :<C-u>Gdiffsplit<CR>
nnoremap [fugitive]D :<C-u>Git diff --staged<CR>
vnoremap ,go :Gbrowse<CR>
