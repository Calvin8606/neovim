return {
        "hrsh7th/nvim-cmp",
        dependencies = {
                "hrsh7th/cmp-nvim-lsp", -- LSP source
                "hrsh7th/cmp-buffer", -- Buffer source
                "hrsh7th/cmp-path", -- Path source
                "hrsh7th/cmp-cmdline", -- Command-line completion
                "L3MON4D3/LuaSnip", -- Snippet engine
                "saadparwaiz1/cmp_luasnip", -- Snippet completion source
                "rafamadriz/friendly-snippets", -- Predefined snippets
        },
        config = function()
                local cmp = require("cmp")
                local luasnip = require("luasnip")

                require("luasnip.loaders.from_vscode").lazy_load() -- Load snippets

                cmp.setup({
                        snippet = {
                                expand = function(args)
                                        luasnip.lsp_expand(args.body) -- Use LuaSnip for snippets
                                end,
                        },
                        mapping = cmp.mapping.preset.insert({
                                ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
                                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
                                ["<Tab>"] = cmp.mapping(function(fallback)
                                        if cmp.visible() then
                                                cmp.select_next_item()
                                        elseif luasnip.expand_or_jumpable() then
                                                luasnip.expand_or_jump()
                                        else
                                                fallback()
                                        end
                                end, { "i", "s" }),
                                ["<S-Tab>"] = cmp.mapping(function(fallback)
                                        if cmp.visible() then
                                                cmp.select_prev_item()
                                        elseif luasnip.jumpable(-1) then
                                                luasnip.jump(-1)
                                        else
                                                fallback()
                                        end
                                end, { "i", "s" }),
                        }),
                        sources = cmp.config.sources({
                                { name = "nvim_lsp" },
                                { name = "luasnip" },
                                { name = "buffer" },
                                { name = "path" },
                        }),
                })
        end,
}
