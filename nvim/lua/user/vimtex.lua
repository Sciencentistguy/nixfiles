vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk_engines = {
	_ = "-xelatex",
}

vim.g.vimtex_parser_bib_backend = "bibtexparser"

vim.g.vimtex_compiler_latexmk = {
	build_dir = "/tmp/latexmk",
	callback = 1,
	continuous = 1,
	executable = "latexmk",
	hooks = {},
	options = {
		"-xelatex",
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
	},
}
