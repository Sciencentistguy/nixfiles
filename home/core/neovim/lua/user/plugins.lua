require("lazy").setup({
    -- Completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    { "petertriho/cmp-git", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Visual
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        opts = { transparent = true },
        config = function(_, opts)
            require("onedark").setup(opts)
            require("onedark").load()
        end,
    },
    "nvim-lualine/lualine.nvim", -- config in lua/user/statusbar.lua
    {
        "nvim-mini/mini.icons",
        version = "*",
        config = function()
            require("mini.icons").setup()
            require("mini.icons").mock_nvim_web_devicons()
        end,
    },
    "kdheepak/tabline.nvim", -- config in lua/user/statusbar.lua
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main", -- the master branch is frozen and has no install()
        lazy = false, -- main does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()

            -- Parsers for the languages used with the LSP servers/formatters; no-op if installed
            require("nvim-treesitter").install({
                "bash",
                "c",
                "cpp",
                "diff",
                "git_config",
                "gitcommit",
                "haskell",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "nix",
                "python",
                "query",
                "rust",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            })

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

    -- LSP stuff
    "neovim/nvim-lspconfig",
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
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
        config = function()
            local telescope = require("telescope")
            telescope.setup()
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {},
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
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xl",
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
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },

    -- matchup
    {
        "andymass/vim-matchup",
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    -- Misc
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        opts = {
            lsp = { enabled = true, actions = true, completion = true, hover = true },
        },
    },
    "tpope/vim-surround",
    {
        "windwp/nvim-autopairs",
        opts = {},
    },
    "airblade/vim-rooter",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    "godlygeek/tabular",
})
