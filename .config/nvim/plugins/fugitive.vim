nnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]
nnoremap [fugitive]s :<C-u>Gstatus<CR>
nnoremap [fugitive]c :<C-u>Gcommit<CR>
nnoremap [fugitive]C :<C-u>Gcommit --amend<CR>
nnoremap [fugitive]b :<C-u>Gblame<CR>
nnoremap [fugitive]a :<C-u>Gwrite<CR>
nnoremap [fugitive]d :<C-u>Gdiff<CR>
nnoremap [fugitive]D :<C-u>Gdiff --staged<CR>
vnoremap ,go :Gbrowse<CR>
