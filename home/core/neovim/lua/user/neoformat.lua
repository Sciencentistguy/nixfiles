-- <F3> formats the current file / selection
vim.keymap.set({ "n", "v" }, "<F3>", ":Neoformat<cr>", { silent = true })
vim.keymap.set("n", "<leader>f", ":Neoformat<cr>", { silent = true })

-- Custom formatter definitions
vim.g.neoformat_json_prettier = {
    exe = "prettier",
    args = {
        "--stdin",
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
vim.g.neoformat_rust_customrustfmt = {
    exe = "rustfmt",
    args = { "--edition", "2024" },
    stdin = 1,
}

vim.g.neoformat_enabled_haskell = { "ormolu" }
vim.g.neoformat_enabled_python = { "black" }
vim.g.neoformat_enabled_rust = { "customrustfmt" }
vim.g.neoformat_enabled_yaml = { "prettier" }
