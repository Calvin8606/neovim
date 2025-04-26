return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,          -- Load theme first
    config = function()
        vim.o.background = "dark" -- Ensure Gruvbox is in dark mode
        require("gruvbox").setup({
            contrast = "hard", -- Options: "soft", "medium", "hard"
            overrides = {
                SignColumn = { bg = "none" }, -- Customize colors if needed
            },
        })
        vim.cmd("colorscheme gruvbox") -- Apply the colorscheme
    end,
}
