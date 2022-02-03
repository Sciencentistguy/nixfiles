vim.g.mapleader = ","

-- Packer.nvim plugin file
require("user.plugins")

vim.g.rooter_patterns = {'.git', 'Cargo.lock', 'CMakeLists.txt', '*.cabal', 'stack.yaml'}

vim.cmd([[
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
]])

-- Regular vim options (not plugins)
require("user.vim-opts")

-- Set up LSP
require("user.lsp.lsp-installer")

-- Commenter plugin
require("user.comment")

-- Automatically close brackets
require("user.autopair")

-- Fancy statusbar
require("user.statusbar")

-- Show git status in sidebar
require("gitsigns").setup()

-- Plugin initialisation
require("crates").setup()
require("rust-tools").setup()
require("colorizer").setup()

-- TODO:
-- coq_3p
-- vimtex
--

require("coq_3p") {
    { src = "nvimlua", short_name = "nLUA" ,config_only = false}
}

-- Colour scheme
require("onedark").setup {
    transparent = true
}

vim.g.coq_settings = {
    auto_start = "shut-up",
    keymap = { recommended = false }
}

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
vim.api.nvim_set_keymap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })


require("nvim-treesitter.configs").setup {
    ensure_intsalled = "maintained",
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = false,
        extended_mode = true,
    }
}

vim.cmd("COQnow -s")
