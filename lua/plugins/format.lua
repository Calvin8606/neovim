return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")

        -- Define formatting & sources
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua, -- Lua formatter
                null_ls.builtins.formatting.prettier, -- JS, TS, HTML formatter
                null_ls.builtins.completion.spell, -- Spell checker
                null_ls.builtins.formatting.clang_format, -- C, C++
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    local augroup = vim.api.nvim_create_augroup("NoneLsFormatting", { clear = true })
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
    end,
}
