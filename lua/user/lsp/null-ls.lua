local null_ls_status_ok, null_ls = pcall( require, "null-ls" )
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup( {
    debug = false,
    sources = {
        --[[ null_ls.builtins.formatting.google_java_format, ]]
        --[[ formatting.stylua.with({
			extra_args = { "indent_type=Spaces", "indent_width=8", "call_parentheses=None" },
		}), ]]
        formatting.lua_format.with( {
            filetypes = { "lua" },
            -- go and check https://github.com/Koihik/LuaFormatter/blob/master/docs/Style-Config.md
            extra_args = {
                "--column-limit=100",
                "--indent-width=4",
                "--continuation-indent-width=2",
                "--no-keep-simple-control-block-one-line",
                "--no-keep-simple-function-one-line",
                "--extra-sep-at-table-end",
                "--chop-down-parameter",
                "--chop-down-table",
                "--spaces-inside-functiondef-parens",
                "--spaces-inside-functioncall-parens",
                "--spaces-inside-table-braces",
            },
        } ),
        -- formatting.markdownlint.with( {
        --     filetypes = { "markdown" },
        --     extra_args = { "--stdin", "--enable MD007" },
        -- } ), -- markdown formattor
        formatting.sqlfluff.with( {
            filetypes = { "sql", "mysql", "pgsql" },
            extra_args = { "--dialect", "postgres" },
        } ), -- sql formattor
        formatting.astyle.with( {
            filetypes = { "java" },
            -- https://astyle.sourceforge.net/astyle.html
            extra_args = {
                "--style=java",
                "--indent=spaces=4",
                "--pad-header",
                "--pad-oper",
                "--break-closing-braces",
                "--break-one-line-headers",
                "--add-braces",
                "--attach-return-type",
                "--convert-tabs",
            },
        } ),
        formatting.prettier.with( {
            extra_args = {
                "--tab-width=4",
                "--no-semi",
                "--single-quote",
                "--jsx-single-quote",
            },
        } ),
        -- formatting.black.with( { extra_args = { "--fast" } } ),
        -- diagnostics.flake8
    },
} )
