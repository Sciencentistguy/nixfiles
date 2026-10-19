-- Terminals send <c-/> as <c-_>, so bind both
for _, key in ipairs({ "<c-/>", "<c-_>" }) do
    vim.keymap.set({ "n", "v" }, key, "<plug>NERDCommenterToggle", { remap = true, silent = true })
end

vim.g.NERDSpaceDelims = true
