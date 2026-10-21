-- Formatters come from conform.nvim, falling back to the LSP when none is configured (e.g. Rust)
vim.api.nvim_create_user_command("Format", function(args)
    local range
    if args.range > 0 then
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, #vim.fn.getline(args.line2) },
        }
    end
    require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- <F3> formats the current file / selection
vim.keymap.set("n", "<F3>", "<cmd>Format<cr>", { silent = true })
vim.keymap.set("x", "<F3>", ":Format<cr>", { silent = true })
vim.keymap.set("n", "<leader>f", "<cmd>Format<cr>", { silent = true })
