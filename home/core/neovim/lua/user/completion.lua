require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<C-k>"] = false,
        ["<CR>"] = { "accept", "fallback" }, -- Only confirms explicitly selected items
        -- Tab selects the first item, then confirms the selected one
        ["<Tab>"] = {
            function(cmp)
                if not cmp.is_menu_visible() then
                    return false
                end
                if cmp.get_selected_item() then
                    return cmp.accept()
                end
                return cmp.select_next()
            end,
            "snippet_forward",
            "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
        menu = { border = "rounded" },
        list = { selection = { preselect = false, auto_insert = false } },
        documentation = { auto_show = true, window = { border = "rounded" } },
    },
    cmdline = {
        keymap = { preset = "cmdline" },
        completion = { menu = { auto_show = false } },
    },
    sources = {
        min_keyword_length = 2,
        per_filetype = {
            gitcommit = { "git", "buffer" },
        },
        providers = {
            git = { module = "blink-cmp-git", name = "Git" },
        },
    },
    -- The prebuilt binary isn't usable on NixOS, so use the Lua matcher
    fuzzy = { implementation = "lua" },
})
