-- Change the window's directory to the project root of the file being edited
local root_markers = {
    { ".git", "_darcs", ".hg", ".bzr", ".svn" },
    { "Makefile", "package.json" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("user-rooter", { clear = true }),
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        local root = vim.fs.root(args.buf, root_markers)
        if root and root ~= vim.fn.getcwd(0) then
            vim.cmd.lcd(vim.fn.fnameescape(root))
        end
    end,
})
