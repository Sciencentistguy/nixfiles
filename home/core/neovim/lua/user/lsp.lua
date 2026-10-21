vim.lsp.inlay_hint.enable(true)

vim.lsp.log.set_level("WARN")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[g", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true })
vim.keymap.set("n", "]g", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { silent = true })

-- LSP keybinds are buffer-local, set only once a server attaches
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
    callback = function(args)
        local function map(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, silent = true })
        end

        map("gD", vim.lsp.buf.declaration)
        map("gd", "<cmd>Telescope lsp_definitions<cr>")
        map("gr", "<cmd>Telescope lsp_references<cr>")
        map("K", vim.lsp.buf.hover)
        map("<leader>k", vim.lsp.buf.signature_help)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<F18>", vim.lsp.buf.rename)
        map("<leader>ca", vim.lsp.buf.code_action)
        map("<m-cr>", vim.lsp.buf.code_action)
    end,
})

vim.api.nvim_create_user_command("Format", function()
    vim.lsp.buf.format()
end, {})

vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable("pyright")

vim.lsp.enable("hls")

vim.lsp.enable("clangd")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
        },
    },
})
vim.lsp.enable("lua_ls")

vim.lsp.enable("nil_ls")

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "\u{ea87}",
            [vim.diagnostic.severity.WARN] = "\u{ea6c}",
            [vim.diagnostic.severity.INFO] = "\u{ea74}",
            [vim.diagnostic.severity.HINT] = "\u{f0eb}",
        },
    },
})
