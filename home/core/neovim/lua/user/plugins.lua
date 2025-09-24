require("lazy").setup({
    -- Completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/vim-vsnip",

    -- Visual
    {
        "navarasu/onedark.nvim",
        config = function(_)
            local plugin = require("onedark")
            plugin.setup({
                transparent = true,
            })
            plugin.load()
        end,
    },
    "nvim-lualine/lualine.nvim", -- config in lua/user/statusbar.lua
    "kdheepak/tabline.nvim", -- config in lua/user/statusbar.lua
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function(_)
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                },
                matchup = {
                    enbale = true,
                },
                indent = {
                    enable = true,
                },
            })

            local old_ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang
            require("nvim-treesitter.parsers").ft_to_lang = function(ft)
                if ft == "zsh" then
                    return "bash"
                end
                return old_ft_to_lang(ft)
            end
        end,
    },
    "arkav/lualine-lsp-progress",
    "nvim-lua/lsp-status.nvim",

    -- LSP stuff
    "neovim/nvim-lspconfig",
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "junegunn/fzf.vim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        init = function(_)
            local telescope = require("telescope")
            telescope.setup()
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    },

    -- Formatting
    "sbdchd/neoformat",

    -- Git support
    "tpope/vim-git",
    {
        "lewis6991/gitsigns.nvim",
        config = function(_)
            require("gitsigns").setup()
        end,
    },
    {
        "m42e/lgh.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "ibhagwan/fzf-lua",
        },
    },

    -- matchup
    {
        "andymass/vim-matchup",
        init = function(_)
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    -- Misc
    "Saecki/crates.nvim",
    {
        "tpope/vim-surround",
        priority = 1000,
    },
    {
        "windwp/nvim-autopairs",
        config = function(_)
            require("nvim-autopairs").setup({})
        end,
    },
    "airblade/vim-rooter",
    "lukas-reineke/indent-blankline.nvim",
    "Sciencentistguy/nerdcommenter",
    "godlygeek/tabular",
})
