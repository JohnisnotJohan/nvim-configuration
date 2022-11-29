local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall( require, "cmp_nvim_lsp" )
if not status_cmp_ok then
    return
end

-- Gets a new ClientCapabilities object describing the LSP client capabilities.
M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- Enable (broadcasting) snippet capability for completion
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- override cmp_nvim_lsp.default_capabilities through funtions
M.capabilities = cmp_nvim_lsp.default_capabilities( M.capabilities )

M.setup = function()
    local signs = {

        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs( signs ) do
        vim.fn.sign_define( sign.name, { texthl = sign.name, text = sign.text, numhl = "" } )
    end

    local config = {
        virtual_text = false, -- virtual_text: (default true) Use virtual text for diagnostics.
        signs = { -- signs: (default true) Use signs for diagnostics.
            active = signs, -- show signs
        },
        update_in_insert = true, -- update_in_insert: (default false) Update diagnostics in Insert mode (if false, diagnostics are updated on InsertLeave)
        underline = true, -- underline: (default true) Use underline for diagnostics.
        severity_sort = true, -- When true, higher severities are displayed before lower severities (e.g.ERROR is displayed before WARN).
        float = {
            focusable = true, -- Make float focusable
            style = "minimal",
            border = "rounded",
            source = "always", -- Include the diagnostic source in the message.
            header = "", -- String to use as the header for the floating window.
            prefix = "",
        },
    }

    vim.diagnostic.config( config )

    -- lsp-handlers are functions with special signatures that are designed to handle responses and notifications from LSP servers.
    -- To configure the behavior of a builtin lsp-handler, the convenient method vim.lsp.with() is provided for users.
    -- vim.lsp.with({handler}, {override_config}): Function to manage overriding defaults for LSP handlers.
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with( vim.lsp.handlers.hover,
                                                           { border = "rounded" } )

    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with( vim.lsp.handlers.signature_help, { border = "rounded" } )
end

local function lsp_keymaps( bufnr )
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap( bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts )
    keymap( bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts )
    keymap( bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts )
    keymap( bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts )
    keymap( bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts )
    keymap( bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts )
    keymap( bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({bufnr = bufnr, timeout = 5000})<cr>", opts )
    -- keymap( bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.format {timeout = 5000}<cr>", opts )
    keymap( bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts )
    keymap( bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts )
    keymap( bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts )
    keymap( bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts )
    keymap( bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts )
    keymap( bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts )
    keymap( bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts )
    keymap( bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts )
end

-- Callback invoked by Nvim's built-in client when attaching a buffer to a language server. Often used to set Nvim (buffer or global) options or to override the Nvim client properties (`resolved_capabilities`) after a language server attaches. Most commonly used for settings buffer local keybindings. See |lspconfig-keybindings| for a usage example.
M.on_attach = function( client, bufnr )
    if client.name == "tsserver" then
        -- client.server_capabilities.document_formatting = false -- Nvim 7.
        client.server_capabilities.documentFormattingProvider = false -- Nvim 8.
        -- require'illuminate'.on_attach( client )
    end

    if client.name == "sqls" then
        require( 'sqls' ).on_attach( client, bufnr )
        client.server_capabilities.documentFormattingProvider = false -- Nvim 8.
    end

    if client.name == "jdtls" then
        vim.lsp.codelens.refresh()
        -- client.server_capabilities.document_formatting = false -- Nvim 7.
        client.server_capabilities.documentFormattingProvider = false -- Nvim 8.
        if JAVA_DAP_ACTIVE then
            require( "jdtls" ).setup_dap( { hotcodereplace = "auto" } )
            require( "jdtls.dap" ).setup_dap_main_class_configs()
        end
        -- require'illuminate'.on_attach( client )
    end

    if client.name == "sumneko_lua" then
        -- client.server_capabilities.document_formatting = false -- Nvim 7.
        client.server_capabilities.documentFormattingProvider = false -- Nvim 8.
        -- require'illuminate'.on_attach( client )
    end

    if client.name == "marksman" then
        client.server_capabilities.documentFormattingProvider = false -- Nvim 8.
    end
    lsp_keymaps( bufnr )
end

return M
