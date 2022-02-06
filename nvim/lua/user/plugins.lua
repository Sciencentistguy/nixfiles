-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	use("tpope/vim-surround")
	use("airblade/vim-rooter")
	use("andymass/vim-matchup")
	use("windwp/nvim-autopairs")
	use("m42e/vim-lgh")
	use("Saecki/crates.nvim")
	use("tpope/vim-git")
	use("norcalli/nvim-colorizer.lua")
	use("sbdchd/neoformat")

	use("simrat39/rust-tools.nvim")

	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use("nvim-telescope/telescope-ui-select.nvim")

	use("Pocco81/AutoSave.nvim")

	-- Pinned because of this https://github.com/ms-jpq/coq_nvim/issues/447
	use({ "ms-jpq/coq_nvim", commit = "b45ca110e43e72aa13d8f762f3e107bd0c107d83" })

	use("ms-jpq/coq.thirdparty")
	use("ms-jpq/coq.artifacts")
	use("lervag/vimtex")

	use("Sciencentistguy/nerdcommenter")

	use("nvim-treesitter/nvim-treesitter")

	use("monsonjeremy/onedark.nvim")
	use("nvim-lualine/lualine.nvim")
	use("arkav/lualine-lsp-progress")
	use("nvim-lua/lsp-status.nvim")

	use("lukas-reineke/indent-blankline.nvim")

	-- use("SirVer/ultisnips")

	use("ray-x/lsp_signature.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})

	use({
		"kdheepak/tabline.nvim",
		requires = {
			{ "hoob3rt/lualine.nvim", opt = true },
			{ "kyazdani42/nvim-web-devicons", opt = true },
		},
	})
end)
