-- Rust is formatted through rust-analyzer so rustfmt picks up the crate's edition and config
local function format()
    if vim.bo.filetype == "rust" then
        vim.lsp.buf.format()
    else
        vim.cmd.Neoformat()
    end
end

-- <F3> formats the current file / selection
vim.keymap.set("n", "<F3>", format, { silent = true })
vim.keymap.set("x", "<F3>", ":Neoformat<cr>", { silent = true })
vim.keymap.set("n", "<leader>f", format, { silent = true })

-- Custom formatter definitions
vim.g.neoformat_json_prettier = {
    exe = "prettier",
    args = {
        "--stdin-filepath",
        '"%:p"',
        "--parser",
        "json",
        "--tab-width",
        "2",
        "--print-width",
        "100",
    },
    stdin = 1,
}
vim.g.neoformat_enabled_haskell = { "ormolu" }
vim.g.neoformat_enabled_python = { "black" }
vim.g.neoformat_enabled_yaml = { "prettier" }
