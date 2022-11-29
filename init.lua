-- :help lua-require
-- "user.options" equals to "lua.user.options.lua"
require("user.options") -- general settings
require("user.keymaps") -- key mappings
require("user.plugins") -- plugin manager
require("user.colorscheme") -- colorcheme
--[[ require "user.colorscheme.lua.darkplus" ]]
require("user.cmp") -- autocompletion
-- lsp is a directory in /user, thus "user.lsp" equals to "lua.user.lsp.init.lua"
require("user.lsp") -- bulitin lsp
require("user.telescope") -- telescope
require("user.treesitter") -- treesitter
require("user.autopairs") -- autopairs
require("user.comment") -- comments operator
require("user.nvim-tree") -- file explorer
require("user.bufferline") -- show buffers in tabline
require("user.lualine") --  beautify your statusline
require("user.toggleterm") -- toggle differnt terminal
require("user.alpha") -- start screen
require("user.colorizer") -- show colors
require("user.dap") -- java debug
--[[ require "user.lir" -- file explorer ]]
require("user.numb") -- numb.nvim is a Neovim plugin that peeks lines of the buffer in non-obtrusive way.
require("user.bookmark")
require("user.hop") -- easy motion | substitution for quickscope and sneak
-- require "user.quickscope" -- highligting when type f/t
-- require "user.sneak" -- highlighting when type s
require("user.which-key") -- key binding
require("user.browse") -- open browser
require("user.auto-session") -- sessions
require("user.inlay-hints")
require("user.illuminate") -- lsp highligting
require("user.symbol-outline") -- lsp outline
-- require "user.nvim-surround" -- nead nvim0.8+
require("user.indentline") -- customized indent line
require("user.project") -- project management
require("user.ranger") -- use ranger to preview file instead of telescope-media-files
require("user.markdown-preview")
