vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

-- Plugin specs (lazy.nvim)
require("user.plugins")

require("user.cmp")
require("user.comment")
require("user.lsp")
require("user.neoformat")
require("user.statusbar")
require("user.vim-opts")

-- Reopen where you left off
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("user-restore-cursor", { clear = true }),
    callback = function(args)
        if vim.bo[args.buf].filetype == "gitcommit" then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})
