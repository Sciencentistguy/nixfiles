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

local ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang
require("nvim-treesitter.parsers").ft_to_lang = function(ft)
    if ft == "zsh" then
        return "bash"
    end
    return ft_to_lang(ft)
end
