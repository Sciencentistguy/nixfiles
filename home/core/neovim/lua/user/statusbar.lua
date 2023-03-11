require("lualine").setup({
    options = {
        theme = "onedark",
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(str)
                    return str:lower()
                end,
            },
        },
        lualine_b = {
            "branch",
            "diff",
        },
        lualine_c = {
            {
                "filename",
                symbols = {
                    modified = " [+]",
                    readonly = " [readonly]",
                    unnamed = "[No Name]",
                },
            },
            {
                "lsp_progress",
                spinner_symbols = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
            },
        },
        lualine_x = {
            "filetype",
            "encoding",
            {
                "fileformat",
                symbols = {
                    unix = "unix",
                    dos = "dos",
                    mac = "mac",
                },
            },
        },
        lualine_y = {
            "progress",
            "diagnostics",
        },
        lualine_z = {
            "location",
        },
    },
})

require("tabline").setup({
    options = {
        modified_icon = "+ ",
    },
})

vim.cmd([[
set guioptions-=e " Use showtabline in gui vim
set sessionoptions+=tabpages,globals " store tabpages and globals in session
]])
