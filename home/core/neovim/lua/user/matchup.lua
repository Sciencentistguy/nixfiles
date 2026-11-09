-- While searching for a match, vim-matchup's skip callback runs for every candidate bracket, and
-- each run re-queries the treesitter tree over +-stopline lines to rebuild the same set of skipped
-- (string/comment) nodes: ~2ms per candidate, so % on a 100 line function took ~190ms.
-- That set only changes when the buffer does, so reuse it while the cursor stays inside the
-- window it was built from.
local syntax = require("treesitter-matchup.syntax")
local get_skips = syntax.get_skips

---@class user.matchup.SkipCache
---@field buf integer
---@field tick integer
---@field lang string?
---@field first integer first row of the queried window
---@field last integer row after the queried window
---@field skips table<string, true>

---@type user.matchup.SkipCache?
local cached

---@param bufnr integer
---@param cursor integer[]
---@return string?
local function lang_at(bufnr, cursor)
    local parser = vim.treesitter.get_parser(bufnr, nil, { error = false })
    if not parser then
        return nil
    end
    local row, col = cursor[1] - 1, cursor[2]
    return parser:language_for_range({ row, col, row, col }):lang()
end

---@param bufnr integer
function syntax.get_skips(bufnr)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1
    local tick = vim.b[bufnr].changedtick
    local lang = lang_at(bufnr, cursor)

    if
        cached
        and cached.buf == bufnr
        and cached.tick == tick
        and cached.lang == lang
        and row >= cached.first
        and row < cached.last
    then
        return cached.skips
    end

    -- Same window that treesitter-matchup.internal.get_matches queries around the cursor
    local stopline = vim.g.matchup_treesitter_stopline
    local skips = get_skips(bufnr)
    cached = {
        buf = bufnr,
        tick = tick,
        lang = lang,
        first = math.max(cursor[1] - stopline, 0),
        last = math.min(cursor[1] + stopline, vim.api.nvim_buf_line_count(bufnr)),
        skips = skips,
    }
    return skips
end
