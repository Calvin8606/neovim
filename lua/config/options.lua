local M = {}

-- Numbers
vim.opt.relativenumber = true
vim.opt.expandtab = true
-- Set proper indentation for C++
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "c", "h", "hpp" },
	callback = function()
		vim.opt.tabstop = 2      -- Number of spaces per tab
		vim.opt.shiftwidth = 2   -- Number of spaces per indentation
		vim.opt.softtabstop = 2  -- Make <Tab> feel like spaces
		vim.opt.expandtab = true -- Convert tabs to spaces
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--         pattern = { "c", "h" },
--         callback = function()
--                 vim.opt.tabstop = 2 -- Number of spaces a tab counts for
--                 vim.opt.shiftwidth = 2 -- Number of spaces for indentation
--                 vim.opt.expandtab = true -- Convert tabs to spaces
--         end,
-- })

-- Copy/Paste
vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
	virtual_text = true, -- Shows inline error text
	signs = true,  -- Shows signs in the gutter
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

return M -- Ensure this line is present
