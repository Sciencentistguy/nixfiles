vim.loader.enable()

vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Failed to clone lazy.nvim:\n" .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specs (lazy.nvim)
require("user.plugins")

require("user.completion")
require("user.comment")
require("user.lsp")
require("user.format")
require("user.rooter")
require("user.statusbar")
require("user.vim-opts")

-- Reopen where you left off
local no_restore_cursor = { gitcommit = true, gitrebase = true, hgcommit = true }
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("user-restore-cursor", { clear = true }),
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" or no_restore_cursor[vim.bo[args.buf].filetype] then
            return
        end
        local win = vim.fn.bufwinid(args.buf)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        if win ~= -1 and mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
            pcall(vim.api.nvim_win_set_cursor, win, mark)
        end
    end,
})
