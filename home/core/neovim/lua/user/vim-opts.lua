local options = {
    background = "dark",
    colorcolumn = "100",
    expandtab = true,
    ignorecase = true,
    linebreak = true,
    mouse = "nv",
    number = true,
    scrolloff = 7,
    shiftwidth = 4,
    showmatch = true,
    showmode = false,
    smartcase = true,
    spelllang = "en_gb",
    swapfile = false,
    tabstop = 4,
    undofile = true,
    updatetime = 300,
    whichwrap = "<,>,h,l",
    winborder = "rounded",
    wildignore = {
        "*.o",
        "*~",
        "*.pyc",
        "*/.git/*",
        "*/.hg/*",
        "*/.svn/*",
        "*/.DS_Store",
    },
    writebackup = false,
    backup = false,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

----
-- Mappings
----

local map = vim.keymap.set
local telescope = function(picker)
    return function()
        require("telescope.builtin")[picker]()
    end
end

-- Disable arrow keys
map({ "n", "x", "o" }, "<Up>", "<Nop>")
map({ "n", "x", "o" }, "<Left>", "<Nop>")
map({ "n", "x", "o" }, "<Down>", "<Nop>")
map({ "n", "x", "o" }, "<Right>", "<Nop>")

-- `<c-{h,j,k,l}>` moves between windows
map({ "n", "x" }, "<c-h>", "<c-w>h")
map({ "n", "x" }, "<c-j>", "<c-w>j")
map({ "n", "x" }, "<c-k>", "<c-w>k")
map({ "n", "x" }, "<c-l>", "<c-w>l")

-- Disable the worst feature of vim
map("n", "q:", "<Nop>")
map("n", "q/", "<Nop>")
map("n", "q?", "<Nop>")

-- Unbind `{` and `}` in vmode
map("x", "{", "<Nop>")
map("x", "}", "<Nop>")

-- Annoying
map({ "n", "x" }, "Q", "<Nop>")

-- `<F1>` is really irritating
map({ "n", "x", "o", "i" }, "<F1>", "<Nop>")

-- `H` and `L` are useless and annoying
map({ "n", "x" }, "H", "h")
map({ "n", "x" }, "L", "l")

-- `s` works like `d` but doesn't yank to buffer
map({ "n", "x" }, "s", '"_d')
map("n", "ss", '"_dd')
map("n", "S", '"_D')

-- `j` and `k` move by wrapped line, unless it would break things
map({ "n", "x" }, "k", function()
    return vim.v.count == 0 and "gk" or "k"
end, { expr = true })
map({ "n", "x" }, "j", function()
    return vim.v.count == 0 and "gj" or "j"
end, { expr = true })

-- `0` moves to the beginning of a line, not necessaryily column 0
map({ "n", "x", "o" }, "0", "^")

-- `,<cr>` clears highlights
map("n", "<leader><cr>", "<cmd>noh<cr>", { silent = true })

-- `,h` and `,l` move around buffers
map("n", "<leader>l", "<cmd>bnext<cr>", { silent = true })
map("n", "<leader>h", "<cmd>bprev<cr>", { silent = true })

-- `,e` searches for files to edit
map("n", "<leader>e", telescope("find_files"), { silent = true })

-- `,rg` searches text
map("n", "<leader>rg", telescope("live_grep"), { silent = true })

-- `,D` lists diagnostics
map("n", "<leader>D", telescope("diagnostics"), { silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("user-yank-highlight", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
