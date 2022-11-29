local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap( "", ",", "<Nop>", opts )
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap( "n", "<C-h>", "<C-w>h", opts )
keymap( "n", "<C-j>", "<C-w>j", opts )
keymap( "n", "<C-k>", "<C-w>k", opts )
keymap( "n", "<C-l>", "<C-w>l", opts )

--[[ keymap("n", "<leader>e", ":Lex 30<cr>", opts)        -- Lex for the explorer in the left ]]

-- Resize with arrows
keymap( "n", "<C-Up>", ":resize +2<CR>", opts )
keymap( "n", "<C-Down>", ":resize -2<CR>", opts )
keymap( "n", "<C-Left>", ":vertical resize -2<CR>", opts )
keymap( "n", "<C-Right>", ":vertical resize +2<CR>", opts )

-- Navigate buffers
keymap( "n", "<S-l>", ":bnext<CR>", opts )
keymap( "n", "<S-h>", ":bprevious<CR>", opts )

-- Navigate tab
keymap( "n", "<A-,>", ":tabn<cr>", opts )
keymap( "n", "<A-.>", ":tabp<cr>", opts )

-- insert an new line
keymap( "n", "<cr>", "o<esc>", opts )

-- pageup & pagedown
keymap( "n", "<A-n>", "<PageDown>", opts )
keymap( "n", "<A-p>", "<PageUp>", opts )

-- clear screen
keymap( "n", "<A-l>", "<cmd>:noh<cr>", opts )

-- Insert --
-- Press jk fast to enter
keymap( "i", "jk", "<ESC>", opts )

-- Navigate under insert mode
keymap( "i", "<A-h>", "<left>", opts )
keymap( "i", "<a-j>", "<down>", opts )
keymap( "i", "<a-k>", "<up>", opts )
keymap( "i", "<A-l>", "<right>", opts )
keymap( "i", "<A-H>", "<left>", opts )
keymap( "i", "<a-J>", "<down>", opts )
keymap( "i", "<a-K>", "<up>", opts )
keymap( "i", "<A-l>", "<right>", opts )

-- move to fistr/last non-blank characters
keymap( "i", "<C-l>", "<esc>g_a", opts )
keymap( "i", "<C-h>", "<esc>^i", opts )

-- Visual --
-- Stay in indent mode
keymap( "v", "<", "<gv", opts )
keymap( "v", ">", ">gv", opts )

-- Move text up and down
keymap( "v", "<A-j>", ":m .+1<CR>==", opts )
keymap( "v", "<A-k>", ":m .-2<CR>==", opts )
-- better paste(when paste on a selected text, the register won't be changed to the yank one)
keymap( "v", "p", '"_dP', opts )

-- rightmost and leftmost
keymap( "v", "L", "$", opts )
keymap( "v", "H", "0", opts )

-- Visual Block --
-- Move text up and down
keymap( "x", "J", ":move '>+1<CR>gv-gv", opts )
keymap( "x", "K", ":move '<-2<CR>gv-gv", opts )
keymap( "x", "<A-j>", ":move '>+1<CR>gv-gv", opts )
keymap( "x", "<A-k>", ":move '<-2<CR>gv-gv", opts )

-- Command -- (there porbably is bug in keymap() in command mode)
--
-- paste content from clipboard. :help c-CTRL-R
vim.cmd "cnoremap <C-v> <C-r>+"

-- cursor movement and popmenu navigation
vim.cmd [[cnoremap <expr> <A-h> pumvisible() ? "\<Up>"   : "\<Left>"]]
vim.cmd [[cnoremap <expr> <A-H> pumvisible() ? "\<Up>"   : "\<Left>"]]
vim.cmd [[cnoremap <expr> <A-l> pumvisible() ? "\<Down>" : "\<Right>"]]
vim.cmd [[cnoremap <expr> <A-L> pumvisible() ? "\<Down>" : "\<Right>"]]

-- histroy query and popmenu navigation. Check :help wildmenu.
-- Notes: there is no changed short-key when 'wildoptions' = pum
vim.cmd [[cnoremap <expr> <A-j> pumvisible() ? "\<Right>" : "\<Down>"]]
vim.cmd [[cnoremap <expr> <A-J> pumvisible() ? "\<Right>" : "\<Down>"]]
vim.cmd [[cnoremap <expr> <A-k> pumvisible() ? "\<Left>"  : "\<Up>"]]
vim.cmd [[cnoremap <expr> <A-K> pumvisible() ? "\<Left>"  : "\<Up>"]]

-- accept the currently selected match and stop completion.
-- :help 'wildmenu'
vim.cmd "cnoremap <A-U> <C-Y>"
vim.cmd "cnoremap <A-u> <C-Y>"

-- end completion, go back to what was there before selecting a match.
-- :help 'wildmenu'
vim.cmd "cnoremap <A-m> <C-E>"
vim.cmd "cnoremap <A-M> <C-E>"

-- rightmost and leftmost 
vim.cmd "cnoremap <C-h> <C-b>"
vim.cmd "cnoremap <C-l> <C-e>"

-- Terminal --
-- Better terminal navigation
keymap( "t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts )
keymap( "t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts )
keymap( "t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts )
keymap( "t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts )

-- from terminal to Terminal-normal mode
-- keymap( "t", "<A-q>", "<C-\\><C-n>", term_opts ) -- set in the toggleterm.lua

-- Operatot --
-- rightmost and leftmost
keymap( "o", "L", "$", opts )
keymap( "o", "H", "0", opts )

-- not good print highlight group
-- vim.cmd [[
-- function! SynGroup()
--     let l:s = synID(line('.'), col('.'), 1)
--     echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
-- endfun
-- ]]


-- not good print highlight group
-- vim.cmd [[
-- function! SynStack()
--   if !exists("*synstack")
--     return
--   endif
--   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
-- endfunc
-- ]]

-- good print highlight group
vim.cmd [[
nnoremap <F4> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
]]

-- open url under the cursor
keymap( "n", "gu", '<cmd>lua require("user.functions").open_url_under_cursor()<CR>', opts )
keymap( "n", "gU", '<cmd>lua require("user.functions").open_url_under_cursor_prefix_github()<CR>', opts )
