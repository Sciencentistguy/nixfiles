-- Terminals send <c-/> as <c-_>, so bind both
for _, key in ipairs({ "<c-/>", "<c-_>" }) do
    vim.keymap.set("n", key, "gcc", { remap = true, silent = true })
    vim.keymap.set("x", key, "gc", { remap = true, silent = true })
end
