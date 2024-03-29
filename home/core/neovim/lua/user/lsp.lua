vim.lsp.set_log_level("debug")

-- Set keybinds
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F18>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "<m-cr>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap(
    "n",
    "[g",
    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    opts
)
vim.api.nvim_set_keymap(
    "n",
    "]g",
    '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    opts
)

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

local lsp = require("lspconfig")

lsp.pyright.setup({})

lsp.hls.setup({})

lsp.clangd.setup({})

lsp.solargraph.setup({})

-- Rust
require("rust-tools").setup({
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
                inlayHints = {
                    locationLinks = false,
                },
            },
        },
    },
})

lsp.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})

lsp.nil_ls.setup({})
