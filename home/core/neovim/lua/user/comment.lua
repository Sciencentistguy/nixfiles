vim.api.nvim_set_keymap("", "<c-/>", "<plug>NERDCommenterToggle <cr>", { silent = true })
vim.api.nvim_set_keymap("v", "<c-/>", "<plug>NERDCommenterToggle", { silent = true })
vim.api.nvim_set_keymap("", "", "<plug>NERDCommenterToggle <cr>", { silent = true })
vim.api.nvim_set_keymap("v", "", "<plug>NERDCommenterToggle", { silent = true })

vim.g.NERDSpaceDelims = true
