vim.g.mapleader = ","

-- Packer.nvim plugin file
require("user.plugins")

require("user.cmp")
require("user.comment")
require("user.lsp")
require("user.neoformat")
require("user.statusbar")
require("user.vim-opts")

-- Cannot be in the packer `config` block for... some reason
require("onedark").setup({
    transparent = true,
})
require("onedark").load()

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
    matchup = {
        enbale = true,
    },
})
