require("lazy").setup({
    -- Completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "petertriho/cmp-git",

    -- Visual
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function(_)
            local plugin = require("onedark")
            plugin.setup({
                transparent = true,
            })
            plugin.load()
        end,
    },
    "nvim-lualine/lualine.nvim", -- config in lua/user/statusbar.lua
    { "nvim-mini/mini.icons", version = "*" },
    "kdheepak/tabline.nvim", -- config in lua/user/statusbar.lua
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function(_)
            require("nvim-treesitter").setup()

            vim.treesitter.language.register("bash", "zsh")

            -- The main branch no longer enables modules from setup(); start per filetype
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
                callback = function(args)
                    if pcall(vim.treesitter.start, args.buf) then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
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
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function(_)
            local telescope = require("telescope")
            telescope.setup()
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {
            diagnostics = {
                auto_close = true,
                auto_open = true,
            },
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
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
