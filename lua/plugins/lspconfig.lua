return {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
                require("mason").setup()
                require("mason-lspconfig").setup({
                        ensure_installed = { "lua_ls", "clangd", "rust_analyzer", "zls" },
                        automatic_installation = false,
                })

                local lspconfig = require("lspconfig")
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                lspconfig.lua_ls.setup({
                        settings = {
                                Lua = {
                                        diagnostics = {
                                                globals = { "vim", "require" },
                                        },
                                        workspace = {
                                                library = vim.api.nvim_get_runtime_file("", true),
                                                checkThirdParty = false,
                                        },
                                        telemetry = {
                                                enable = false,
                                        },
                                },
                        },
                })

                -- lspconfig.gopls.setup({
                --         capabilities = capabilities,
                --         settings = {
                --                 gopls = {
                --                         gofumpt = false, -- set to true if you want gofumpt behavior
                --                         -- local = "your/module/name", -- optional: for grouping imports under your module
                --                         analyses = {
                --                                 unusedparams = true,
                --                         },
                --                         usePlaceholders = true,
                --                         completeUnimported = true,
                --                 },
                --         },
                --         on_attach = function(client, bufnr)
                --                 client.server_capabilities.documentFormattingProvider = true
                --
                --                 vim.api.nvim_create_autocmd("BufWritePre", {
                --                         group = vim.api.nvim_create_augroup("GoAutoFormat", { clear = true }),
                --                         buffer = bufnr,
                --                         callback = function()
                --                                 vim.lsp.buf.format({ async = false })
                --                         end,
                --                 })
                --         end,
                -- })

                -- C++ setup
                lspconfig.clangd.setup({
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern(".git", "Makefile"),
                        on_attach = function(client, bufnr)
                                -- -- Enable LSP-based formatting
                                client.server_capabilities.documentFormattingProvider = true
                                --
                                -- -- Remove `pattern`, only use `buffer`
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                        group = vim.api.nvim_create_augroup("ClangdAutoFormat", { clear = true }),
                                        buffer = bufnr, -- Only apply to the current buffer
                                        callback = function()
                                                vim.lsp.buf.format({ async = false })
                                        end,
                                })
                        end,
                })

                -- Rust setup
                lspconfig.rust_analyzer.setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                                -- Enable LSP-based formatting
                                client.server_capabilities.documentFormattingProvider = true

                                -- Auto-format Rust files before saving
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                        group = vim.api.nvim_create_augroup("RustAutoFormat", { clear = true }),
                                        buffer = bufnr,
                                        callback = function()
                                                vim.lsp.buf.format({ async = false })
                                        end,
                                })
                        end,
                })

                vim.api.nvim_create_autocmd("BufWritePre", {
                        pattern = { "*.zig", "*.zon" },
                        callback = function()
                                vim.lsp.buf.format({ async = false })
                        end,
                })

                -- OLS FOR ODIN

                lspconfig.ols.setup({
                        cmd = { "/Users/calvin/ols/ols" },
                        init_options = {
                                checker_args = "-strict-style",
                        },
                        on_attach = function(client, bufnr)
                                -- Disable LSP formatting so it doesn't conflict with conform.nvim
                                client.server_capabilities.documentFormattingProvider = false
                        end,
                })

                lspconfig.zls.setup({
                        capabilities = capabilities,
                        filetypes = { "zig", "zir" },
                        root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
                        single_file_support = true,
                        on_attach = function(client, bufnr)
                                -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover (Zig)" })

                                -- Optional: prevent semantic token errors
                                client.server_capabilities.semanticTokensProvider = nil

                                -- Enable formatting
                                client.server_capabilities.documentFormattingProvider = true

                                -- Auto-format on save
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                        group = vim.api.nvim_create_augroup("ZigAutoFormat", { clear = true }),
                                        buffer = bufnr,
                                        callback = function()
                                                vim.lsp.buf.format({ async = false })
                                        end,
                                })
                        end,
                })
        end,
}
