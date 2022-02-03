-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	use("tpope/vim-surround")
	-- use "airblade/vim-gitgutter"
	use("airblade/vim-rooter")
	use("andymass/vim-matchup")
	use("windwp/nvim-autopairs")
	use("m42e/vim-lgh")
	use("Saecki/crates.nvim")
	use("tpope/vim-git")
	use("norcalli/nvim-colorizer.lua")

	use("simrat39/rust-tools.nvim")

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		-- tag = 'release' -- To use the latest release
	})

	use("Pocco81/AutoSave.nvim")

	use("ms-jpq/coq_nvim")
	use("ms-jpq/coq.thirdparty")
	use("ms-jpq/coq.artifacts")

	use("numToStr/Comment.nvim")

	use("nvim-treesitter/nvim-treesitter")
	use("p00f/nvim-ts-rainbow")

	use("monsonjeremy/onedark.nvim")
	use("nvim-lualine/lualine.nvim")
	use("lukas-reineke/indent-blankline.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})

	use({
		"kdheepak/tabline.nvim",
		requires = { { "hoob3rt/lualine.nvim", opt = true }, { "kyazdani42/nvim-web-devicons", opt = true } },
	})
end)
