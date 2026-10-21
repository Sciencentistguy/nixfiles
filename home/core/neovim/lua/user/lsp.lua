vim.lsp.inlay_hint.enable(true)

vim.lsp.log.set_level("WARN")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[g", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true })
vim.keymap.set("n", "]g", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { silent = true })

local function telescope(picker)
    return function()
        require("telescope.builtin")[picker]()
    end
end

-- LSP keybinds are buffer-local, set only once a server attaches
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
    callback = function(args)
        local function map(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, silent = true })
        end

        map("gD", vim.lsp.buf.declaration)
        map("gd", telescope("lsp_definitions"))
        map("gr", telescope("lsp_references"))
        map("<leader>k", vim.lsp.buf.signature_help)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<F18>", vim.lsp.buf.rename)
        map("<leader>ca", vim.lsp.buf.code_action)
        map("<m-cr>", vim.lsp.buf.code_action)
    end,
})

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Neovim runtime and plugin types come from lazydev.nvim
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
        },
    },
})

vim.lsp.enable({ "clangd", "hls", "lua_ls", "nil_ls", "ty" })

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
