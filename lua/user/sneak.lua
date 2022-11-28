vim.cmd "let g:sneak#label = 1"

-- case insensitive sneak
vim.cmd "let g:sneak#use_ic_scs = 1"

-- immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
vim.cmd "let g:sneak#s_next = 1"

-- remap so I can use , and ; with f and t
-- map gS <Plug>Sneak_,
-- map gs <Plug>Sneak_;

vim.cmd "map s <Plug>Sneak_s"
vim.cmd "map S <Plug>Sneak_S"
-- Change the colors
vim.cmd "highlight Sneak guifg=Black guibg=#00C7DF ctermfg=black ctermbg=cyan"
vim.cmd "highlight SneakScope guifg=Red guibg=Yellow ctermfg=red ctermbg=yellow"

-- Cool prompts
-- let g:sneak#prompt = '🕵s'
-- let g:sneak#prompt = '🔎'


