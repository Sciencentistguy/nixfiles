vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

print(lazypath)

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Packer.nvim plugin file
require("user.plugins")

require("user.cmp")
require("user.comment")
require("user.lsp")
require("user.neoformat")
require("user.statusbar")
require("user.vim-opts")

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

-- Reopen where you left off
vim.cmd([[
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
]])

-- Last !!
vim.api.nvim_set_keymap("v", "S", "<Plug>VSurround", { noremap = true, silent = true })
