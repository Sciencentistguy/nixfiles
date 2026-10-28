-- Terminals send <c-/> as <c-_>, so bind both
for _, key in ipairs({ "<c-/>", "<c-_>" }) do
    vim.keymap.set("n", key, "gcc", { remap = true, silent = true })
    vim.keymap.set("x", key, "gc", { remap = true, silent = true })
end

-- NERDCommenter muscle memory: the built-in commenting only toggles, so these all do the same
for _, suffix in ipairs({ "c", "s", "m", "i", "u", "<space>" }) do
    vim.keymap.set("n", "<leader>c" .. suffix, "gcc", { remap = true, silent = true })
    vim.keymap.set("x", "<leader>c" .. suffix, "gc", { remap = true, silent = true })
end
