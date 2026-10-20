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
            function()
                return vim.lsp.status()
            end,
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
    icons_enabled = true,
})

require("tabline").setup({
    options = {
        modified_icon = "+ ",
    },
})
