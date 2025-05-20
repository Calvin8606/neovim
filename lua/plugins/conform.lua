return {
        "stevearc/conform.nvim",
        opts = {
                notify_on_error = false,
                format_on_save = {
                        timeout_ms = 1000,
                        lsp_fallback = false, -- don't fallback to LSP; use only odinfmt
                },
                formatters = {
                        odinfmt = {
                                command = "/Users/calvin/ols/odinfmt",
                                args = { "-stdin" },
                                stdin = true,
                        },
                },
                formatters_by_ft = {
                        odin = { "odinfmt" },
                },
        },
}
