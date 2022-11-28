vim.cmd [[highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline]]
vim.cmd [[highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline]]
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
-- Turn off this plugin when the length of line is longer than g:qs_max_chars. (default: 1000)
vim.cmd [[let g:qs_max_chars=200]]

-- Setting g:qs_buftype_blacklist to a list of buffer types disables the plugin when entering certain buftype's. For example, to disable this plugin when for terminals and floating windows without filetypes set
vim.cmd "let g:qs_buftype_blacklist = ['terminal', 'nofile']"

-- Setting g:qs_filetype_blacklist to a list of file types disables the plugin when entering certain filetypes's. For example, to disable this plugin for dashboard-nvim and vim-startify
vim.cmd "let g:qs_filetype_blacklist = ['dashboard', 'startify']"


