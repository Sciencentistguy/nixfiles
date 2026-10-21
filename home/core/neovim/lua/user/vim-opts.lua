local options = {
    background = "dark",
    colorcolumn = "100",
    expandtab = true,
    fileformats = { "unix", "dos", "mac" },
    ignorecase = true,
    inccommand = "nosplit",
    linebreak = true,
    mouse = "nv",
    number = true,
    scrolloff = 7,
    shiftwidth = 4,
    showmatch = true,
    showmode = false,
    smartcase = true,
    smartindent = true,
    spelllang = "en_gb",
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    updatetime = 300,
    whichwrap = "<,>,h,l",
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

vim.opt.sessionoptions:append({ "tabpages", "globals" }) -- store tabpages and globals in session

----
-- Mappings
----

-- Disable arrow keys
vim.api.nvim_set_keymap("", "<Up>", "", { noremap = true })
vim.api.nvim_set_keymap("", "<Left>", "", { noremap = true })
vim.api.nvim_set_keymap("", "<Down>", "", { noremap = true })
vim.api.nvim_set_keymap("", "<Right>", "", { noremap = true })

-- `<c-{h,j,k,l}>` moves between windows
vim.api.nvim_set_keymap("", "<c-h>", "<c-W>h", {})
vim.api.nvim_set_keymap("", "<c-j>", "<c-W>j", {})
vim.api.nvim_set_keymap("", "<c-k>", "<c-W>k", {})
vim.api.nvim_set_keymap("", "<c-l>", "<c-W>l", {})

-- Disable the worst feature of vim
vim.api.nvim_set_keymap("", "q:", "", { noremap = true })
vim.api.nvim_set_keymap("", "q/", "", { noremap = true })
vim.api.nvim_set_keymap("", "q?", "", { noremap = true })

-- Unbind `{` and `}` in vmode
vim.api.nvim_set_keymap("v", "{", "", { noremap = true })
vim.api.nvim_set_keymap("v", "}", "", { noremap = true })

-- Annoying
vim.api.nvim_set_keymap("", "Q", "", { noremap = true })

-- `<F1>` is really irritating
vim.api.nvim_set_keymap("", "<F1>", "", { noremap = true })
vim.api.nvim_set_keymap("i", "<F1>", "", { noremap = true })

-- `H` and `L` are useless and annoying
vim.api.nvim_set_keymap("", "H", "h", { noremap = true })
vim.api.nvim_set_keymap("", "L", "l", { noremap = true })

-- `s` works like `d` but doesn't yank to buffer
vim.api.nvim_set_keymap("", "s", '"_d', { noremap = true })
vim.api.nvim_set_keymap("", "ss", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("", "S", '"_D', { noremap = true })

-- `j` and `k` move by wrapped line, unless it would break things
vim.api.nvim_set_keymap("", "k", "(v:count == 0 ? 'gk' : 'k')", { noremap = true, expr = true })
vim.api.nvim_set_keymap("", "j", "(v:count == 0 ? 'gj' : 'j')", { noremap = true, expr = true })

-- `0` moves to the beginning of a line, not necessaryily column 0
vim.api.nvim_set_keymap("", "0", "^", {})

-- `Y` yanks to end of line, à la `D`
vim.api.nvim_set_keymap("n", "Y", "y$", {})

-- `,<cr>` clears highlights
vim.api.nvim_set_keymap("", "<leader><cr>", ":noh<cr>", { silent = true })

-- `,h` and `,l` move around buffers
vim.api.nvim_set_keymap("", "<leader>l", ":bnext<cr>", { silent = true })
vim.api.nvim_set_keymap("", "<leader>h", ":bprev<cr>", { silent = true })

-- `,e` searches for files to edit
vim.api.nvim_set_keymap("", "<leader>e", ":Telescope find_files<cr>", { silent = true })

-- `,rg` searches text
vim.api.nvim_set_keymap("", "<leader>rg", ":Telescope live_grep<cr>", { silent = true })

-- `,D` lists diagnostics
vim.api.nvim_set_keymap("", "<leader>D", ":Telescope diagnostics<cr>", { silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("user-yank-highlight", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
