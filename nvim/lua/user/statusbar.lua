require("lualine").setup({
	options = {
		theme = "onedark",
	},
})
require("tabline").setup()
vim.cmd([[
set guioptions-=e " Use showtabline in gui vim
set sessionoptions+=tabpages,globals " store tabpages and globals in session
]])
