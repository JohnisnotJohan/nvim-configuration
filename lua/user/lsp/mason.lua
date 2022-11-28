--[[ QUICK START
Setting up mason-lspconfig.nvim

It's important that you set up the plugins in the following order:

1. `mason.nvim`
2. `mason-lspconfig.nvim`
3. Setup servers via `lspconfig` ]] local servers = {
    "sumneko_lua",
    -- "groovyls",
    -- "cssls",
    -- "html",
    -- "tsserver",
    "pyright",
    -- "jdtls",
    -- "bashls",
    "jsonls",
    -- "yamlls",
    "sqls",
    "marksman",
}

local settings = {
    ui = {
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "double",
        icons = {
            -- The list icon to use for installed packages.
            package_installed = "◍",
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = "◍",
            -- The list icon to use for packages that are not installed.
            package_uninstalled = "◍",
        },
    },
    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,
    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,
    -- default keymaps
    keymaps = {
        -- Keymap to expand a package
        toggle_package_expand = "<CR>",
        -- Keymap to install the package under the current cursor position
        install_package = "i",
        -- Keymap to reinstall/update the package under the current cursor position
        update_package = "u",
        -- Keymap to check for new version for the package under the current cursor position
        check_package_version = "c",
        -- Keymap to update all installed packages
        update_all_packages = "U",
        -- Keymap to check which installed packages are outdated
        check_outdated_packages = "C",
        -- Keymap to uninstall a package
        uninstall_package = "X",
        -- Keymap to cancel a package installation
        cancel_installation = "<C-c>",
        -- Keymap to apply language filter
        apply_language_filter = "<C-f>",
    },
}

-- Notes:
-- `lspconfig` needs to be available in |rtp| so that `mason-lspconfig` can successfully call `require("lspconfig")` (|lua-require|) during setup.
require( "mason" ).setup( settings )
require( "mason-lspconfig" ).setup( {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = servers,
    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = true,
} )

local lspconfig_status_ok, lspconfig = pcall( require, "lspconfig" )
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs( servers ) do
    opts = {
        on_attach = require( "user.lsp.handlers" ).on_attach,
        capabilities = require( "user.lsp.handlers" ).capabilities,
        -- on_attach_2 = require'illuminate'.on_attach,
    }

    server = vim.split( server, "@" )[1]

    local require_ok, conf_opts = pcall( require, "user.lsp.settings." .. server )
    if require_ok then
        opts = vim.tbl_deep_extend( "force", conf_opts, opts )
    end

    -- `lspconfig` consists of a collection of language server configurations. Each configuration exposes a `setup {}` metamethod which makes it easy to directly use the default configuration or selectively override the defaults. `setup {}` is the primary interface by which users interact with `lspconfig`.
    -- The purpose of `setup{}` is to wrap the call to Nvim's built-in `vim.lsp.start_client()` with an autocommand that automatically launch a language server. This autocommand calls `start_client()` or `vim.lsp.buf_attach_client()` depending on whether the current file belongs to a project with a currently running client. See |lspconfig-root-detection| for more details. 
    -- The `setup{}` function takes a table which contains a superset of the keys listed in `:help vim.lsp.start_client()`
    lspconfig[server].setup( opts )

    --[[ local util = require "lspconfig.util"
  if server == "groovyls" then
    require('lspconfig')['groovyls'].setup{
    cmd = { "java", "-jar", "$HOME/.local/share/nvim/site/pack/packer/start/groovy-language-server/build/libs/groovy-language-server-all.jar" },
    root_dir = util.root_pattern {'gradlew'},
  }
  end ]]

end
