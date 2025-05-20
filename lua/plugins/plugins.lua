return {

        -- TODO COMMENTS
        { "folke/todo-comments.nvim",    opts = {} },
        -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
        -- So for api plugins like devicons, we can always set lazy=true
        { "nvim-tree/nvim-web-devicons", lazy = true },
        -- MASON LANGUAGE INSTALLER
        { "williamboman/mason.nvim",     opts = {} },
        -- PLENARY
        { "nvim-lua/plenary.nvim",       lazy = true }, -- Only loads when needed by another plugin
        -- TREESITTER SYNTAX HIGHLIGHTING
        {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                config = function()
                        require("nvim-treesitter.configs").setup({
                                ensure_installed = "all",
                                ignore_install = { "org" },
                                highlight = { enable = true },
                                indent = { enable = true },
                                autotag = { enable = true },
                        })
                end,
        },
        --FZF - LUA FILE FINDER
        {
                "ibhagwan/fzf-lua",
                dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icons
                config = function()
                        require("fzf-lua").setup({
                                "telescope",
                                -- fzf_bin = "fzf-tmux",
                                fzf_tmux_opts = {
                                        ["--tmux"] = "center,80%,60%",
                                },
                                fzf_colors = {
                                        ["bg"] = { "bg", "Normal" },
                                        ["fg"] = { "fg", "Normal" },
                                        ["border"] = { "fg", "Normal" },
                                },
                                winopts = {
                                        border = "rounded",
                                        height = 0.90,
                                        width = 0.95,
                                        treesitter = { enabled = true, disabled = {} },
                                        preview = {
                                                default = "bat",
                                                -- wrap = "nowrap",
                                                wrap = false,
                                                layout = "vertical",
                                                vertical = "right:50%",
                                                hidden = false,
                                        },
                                },
                                fzf_opts = {
                                        ["--layout"] = "default",
                                        ["--info"] = "inline",
                                        ["--border"] = "bold",
                                        ["--ansi"] = "",
                                        ["--header"] = " ",
                                        ["--no-scrollbar"] = "",
                                },
                                files = {
                                        formatter = "path.filename_first",
                                },
                                buffers = { formatter = "path.filename_first" },
                                manpages = { previewer = "man_native" },
                                helptags = { previewer = "help_native" },
                                tags = { previewer = "bat_async" },
                                keymap = {
                                        builtin = {
                                                ["<C-f>"] = "preview-page-down", -- Down
                                                ["<C-b>"] = "preview-page-up",   -- Up
                                        },
                                },
                        })
                end,
        },

        -- AUTO PAIR EX: {}, (), ""
        {
                "windwp/nvim-autopairs",
                event = "InsertEnter",
                config = function()
                        require("nvim-autopairs").setup({
                                check_ts = true, -- Use Treesitter to check for pairs
                                disable_filetype = { "TelescopePrompt", "vim" },
                        })

                        -- Integrate with nvim-cmp for auto-closing
                        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                        local cmp = require("cmp")
                        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
        },

        -- Comments
        {
                "numToStr/Comment.nvim",
                opts = {},
                config = function()
                        require("Comment").setup()
                end,
        },

        -- Easy Tmux Navigation
        {
                "christoomey/vim-tmux-navigator",
                lazy = false, -- or true if you prefer
        },

        -- Toggle Terminal
        {
                "akinsho/toggleterm.nvim",
                version = "*",
                config = function()
                        require("toggleterm").setup({
                                open_mapping = [[<C-t>]], -- Or any other key combo you like
                                direction = "horizontal", -- or "horizontal", "vertical", "tab"
                        })

                        vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
                end,
        },
}
