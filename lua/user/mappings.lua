local map = vim.keymap.set
local e_opts = { expr = true }
local s_opts = { silent = true }
local se_opts = { silent = true, expr = true }
map("n", "<Leader><Leader>t", function()
    local gitsigns_status = vim.b.gitsigns_status_dict
    if gitsigns_status then
        launch_ext_prog("gnome-terminal", "--working-directory", vim.fn.shellescape(gitsigns_status.root))
    else
        launch_ext_prog("gnome-terminal", "--working-directory", vim.fn.shellescape(vim.fn.expand("%:p:h")))
    end
end, s_opts)
map("n", "<Leader><Leader>e", function()
    launch_ext_prog("nautilus", vim.fn.shellescape(vim.fn.expand("%:p:h")))
end, s_opts)
map("n", "<Leader><Leader>c", function()
    launch_ext_prog(
        "code",
        "-g",
        vim.fn.shellescape(vim.api.nvim_buf_get_name(0) .. ":" .. table.concat(vim.api.nvim_win_get_cursor(0), ":"))
    )
end, s_opts)
map("n", "<Leader><Leader>n", function()
    launch_ext_prog("gedit", vim.fn.shellescape(vim.fn.expand("%:p")))
end, s_opts)
map("n", "<Leader>ou", function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local col, _ = vim.api.nvim_get_current_line():find("https?")
    if not col then
        return
    end
    vim.api.nvim_win_set_cursor(0, { pos[1], col - 1 })
    open_url(vim.fn.expand("<cfile>"))
    vim.api.nvim_win_set_cursor(0, pos)
end, s_opts)
map("n", "<Leader>or", function()
    open_url(vim.fn.expand("<cfile>"), [[https://github.com/]])
end, s_opts)
map("n", "<F2>", [[:%s/\<<C-r><C-w>\>/]])
map("v", "<F2>", [[<Esc>:%s/<C-r>=EscapeString(GetVisualSelection())<CR>/]])
map("n", "<C-s>", "<cmd>update!<CR>", s_opts)
map("i", "<C-s>", "<Esc><cmd>update!<CR>", s_opts)
map("n", "<C-S-s>", "<cmd>lua save_reload_module()<CR>", s_opts)
map("n", "<Leader>q", "<cmd>QFix<CR>", s_opts)
map("n", "<C-f>", "gg=G''zz<Esc>", s_opts)
map("n", "<F10>", "<cmd>setlocal spell!<CR>", s_opts)
map("n", "<F12>", "<cmd>setlocal paste!<CR>", s_opts)
map("n", "<Leader>h", "<cmd>nohl<CR>", s_opts)
map("n", "$", "g_", s_opts)
map("v", "$", "g_", s_opts)
map("n", "Y", '"+yg_', s_opts)
map("n", "y", '"+y', s_opts)
map("v", "y", '"+y', s_opts)
map("i", "<C-v>", "<C-R><C-P>+", s_opts)
map("n", "<C-v>", "i<C-R><C-P>+<ESC>", s_opts)
map("s", "<C-v>", "<BS>i<C-R><C-P>+", s_opts)
map("i", "<C-a>", "<Esc>g_a", s_opts)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", e_opts)
map("n", "k", "v:count == 0 ? 'gk' : 'k'", e_opts)
map("v", "J", "j", s_opts)
map("v", "K", "k", s_opts)
map("i", "<C-z>", "<C-g>u<Esc>[s1z=`]a<C-g>u", s_opts)
map("n", "<C-z>", "1z=<Esc>", s_opts)
map("i", "<C-BS>", "<C-w>", s_opts)
map("i", "<C-Del>", "<C-o>dW", s_opts)
map("n", "<M-]>", ">>", s_opts)
map("n", "<M-[>", "<<", s_opts)
map("x", "<M-]>", ">gv", s_opts)
map("x", "<M-[>", "<gv", s_opts)
map("n", "<C-h>", "<C-w>h", s_opts)
map("n", "<C-l>", "<C-w>l", s_opts)
map("n", "<C-k>", "<C-w>k", s_opts)
map("n", "<C-j>", "<C-w>j", s_opts)
map("", "<S-LeftMouse>", "<nop>")
map("", "<S-LeftDrag>", "<nop>")
map("c", "<C-h>", "<Left>", s_opts)
map("c", "<C-l>", "<Right>", s_opts)
map("n", "<M-d>", "<cmd>t.<CR>", s_opts)
map("i", "<M-d>", "<Esc><cmd>t.<CR>gi", s_opts)
map("n", "<A-j>", ":m .+1<CR>==", s_opts)
map("n", "<A-k>", ":m .-2<CR>==", s_opts)
map("v", "<A-j>", ":m '>+1<CR>gv-gv", s_opts)
map("v", "<A-k>", ":m '<-2<CR>gv-gv", s_opts)
map("n", "<F11>", "<cmd>setlocal linebreak! wrap!<CR>", s_opts)
map("n", "<Leader>w", function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        return "<cmd>cclose<CR>"
    else
        return "<cmd>bd!<CR>"
    end
end, se_opts)
map("n", "<Leader>c", "<cmd>bp | sp | bn | bd<CR>", s_opts)
map("t", "<Esc>", "<C-\\><C-n>", s_opts)
map("n", "n", "nzz", s_opts)
map("n", "N", "Nzz", s_opts)
map("n", "<Space>", "foldlevel('.') ? 'za' : '<Space>'", se_opts)
map("n", "ZZ", "len(getbufinfo({'buflisted':1})) > 1 ? '<cmd>wqall<CR>' : '<cmd>wq<CR>'", se_opts)
map("n", "ZQ", "len(getbufinfo({'buflisted':1})) > 1 ? '<cmd>qall!<CR>' : '<cmd>q!<CR>'", se_opts)
local break_points = { ".", ",", "!", "?", "=", "-", "_" }
for _, v in pairs(break_points) do
    map("i", tostring(v), v .. "<C-g>u", s_opts)
end
