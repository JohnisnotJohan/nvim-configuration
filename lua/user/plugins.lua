local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath( "data" ) .. "/site/pack/packer/start/packer.nvim"
if fn.empty( fn.glob( install_path ) ) > 0 then
    PACKER_BOOTSTRAP = fn.system( {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    } )
    print( "Installing packer close and reopen Neovim..." )
    vim.cmd( [[packadd packer.nvim]] )
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd( [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]] )

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall( require, "packer" )
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init( {
    display = {
        open_fn = function()
            return require( "packer.util" ).float( { border = "rounded" } )
        end,
    },
} )

-- Install your plugins here
return packer.startup( function( use )
    -- My plugins here
    use( "wbthomason/packer.nvim" ) -- Have packer manage itself
    use( "nvim-lua/popup.nvim" ) -- An implementation of the Popup API from vim in Neovim
    use( "nvim-lua/plenary.nvim" ) -- Useful lua functions used ny lots of plugins

    -- Colorschemes
    -- use( "lunarvim/colorschemes" ) -- A bunch of colorschemes you can try out
    use( "ChristianChiarulli/nvcode-color-schemes.vim" )
    -- use { "Mofiqul/vscode.nvim", commit = "c5125820a0915ef50f03fae10423c43dc49c66b1" }
    -- use 'LunarVim/Colorschemes'
    -- use "lunarvim/darkplus.nvim"
    -- use 'martinsione/darkplus.nvim'
    -- use 'joshdick/onedark.vim'

    -- cmp plugins
    use( "hrsh7th/nvim-cmp" ) -- The completion plugin
    use( "hrsh7th/cmp-buffer" ) -- buffer completions
    use( "hrsh7th/cmp-path" ) -- path completions
    use( "hrsh7th/cmp-cmdline" ) -- cmdline completions
    use( "saadparwaiz1/cmp_luasnip" ) -- snippet completions
    use( "hrsh7th/cmp-nvim-lsp" )
    use( "hrsh7th/cmp-nvim-lua" )

    -- snippets
    use( "L3MON4D3/LuaSnip" ) -- snippet engine
    use( "rafamadriz/friendly-snippets" ) -- a bunch of snippets to use

    -- LSP
    use( "neovim/nvim-lspconfig" ) -- enable LSP
    use( "williamboman/mason.nvim" ) -- simple to use language server installer
    use( "williamboman/mason-lspconfig.nvim" ) -- simple to use language server installer
    use( "jose-elias-alvarez/null-ls.nvim" ) -- for formatters and linters
    use( "GroovyLanguageServer/groovy-language-server" ) -- groovy language server
    use( "lvimuser/lsp-inlayhints.nvim" )
    use( "RRethy/vim-illuminate" )
    use( "simrat39/symbols-outline.nvim" )
    use 'nanotee/sqls.nvim' -- sqls command

    -- Telescope
    use( "nvim-telescope/telescope.nvim" )
    -- use("nvim-telescope/telescope-media-files.nvim") -- this project is unmaintained. There is bug when displaying images. It seems that telescope don't clear the image. I use ranger to preview image instead.
    use( "kevinhwang91/rnvimr" ) -- ranger to show image

    --[[ use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  } ]]

    -- Treesitter
    use( {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require( "nvim-treesitter.install" ).update( { with_sync = true } )
            ts_update()
        end,
    } )
    use( "p00f/nvim-ts-rainbow" )
    use( "nvim-treesitter/playground" )
    use( "JoosepAlviste/nvim-ts-context-commentstring" )
    use( "kyazdani42/nvim-web-devicons" )

    -- Autopairs, integrates with both cmp and treesitter
    use( "windwp/nvim-autopairs" )

    -- Editing
    use( "numToStr/Comment.nvim" ) -- Easily comment stuff
    use( "nacro90/numb.nvim" ) -- Peeking the buffer while entering command :{number}
    use( {
        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
        --[[ config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end ]]
    } )
    -- use "unblevable/quick-scope" -- highlighting when type f/t
    -- use "justinmk/vim-sneak"  -- highlighting when type s
    -- use "kylechui/nvim-surround" -- need nvim 0.8+
    use( "tpope/vim-surround" )

    -- File Explorer
    use( "kyazdani42/nvim-tree.lua" )

    -- show buffers
    use( "akinsho/bufferline.nvim" )
    use( "moll/vim-bbye" )

    -- airline
    use( "nvim-lualine/lualine.nvim" )

    -- toggle term(inal)
    use( "akinsho/toggleterm.nvim" )

    -- start screen
    use( "goolord/alpha-nvim" )

    -- JAVA
    use( "mfussenegger/nvim-jdtls" )
    -- Debugger
    use( "mfussenegger/nvim-dap" )
    use( "rcarriga/nvim-dap-ui" )
    -- use "ravenxrz/DapInstall.nvim"
    -- use "ravenxrz/nvim-dap"
    use( "theHamsta/nvim-dap-virtual-text" )

    -- show color
    use( "norcalli/nvim-colorizer.lua" )

    -- Keybinding
    use( "folke/which-key.nvim" )

    -- browerser
    use( "lalitmee/browse.nvim" )

    -- Session
    use( "rmagatti/auto-session" )
    use( "rmagatti/session-lens" )

    -- bookmark
    use( "MattesGroeger/vim-bookmarks" )

    -- colorful indent
    use( "lukas-reineke/indent-blankline.nvim" )

    -- Project
    use( "ahmedkhalf/project.nvim" )

    -- Markdown preview
    use {'iamcco/markdown-preview.nvim'}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require( "packer" ).sync()
    end
end )
