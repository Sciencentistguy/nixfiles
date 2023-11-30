return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Completion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")

    -- Copilot
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/vim-vsnip")

    -- Visual
    use("navarasu/onedark.nvim")
    use("nvim-lualine/lualine.nvim") -- config in lua/user/statusbar.lua
    use("kdheepak/tabline.nvim") -- config in lua/user/statusbar.lua
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })
    use("arkav/lualine-lsp-progress")
    use("nvim-lua/lsp-status.nvim")

    -- LSP stuff
    use("neovim/nvim-lspconfig")
    use("simrat39/rust-tools.nvim")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "junegunn/fzf.vim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup()
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    })

    -- Formatting
    use("sbdchd/neoformat")

    -- Git support
    use("tpope/vim-git")
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    })
    use({
        "m42e/lgh.nvim",
        requires = {
            { "nvim-telescope/telescope.nvim" },
            { "ibhagwan/fzf-lua" },
        },
    })

    -- matchup
    use({
        "andymass/vim-matchup",
        setup = function()
            -- may set any options here
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    })

    -- Misc
    use("Saecki/crates.nvim")
    use("tpope/vim-surround")
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
    use("airblade/vim-rooter")
    use("lukas-reineke/indent-blankline.nvim")
    use("Sciencentistguy/nerdcommenter")
    use("godlygeek/tabular")
end)
