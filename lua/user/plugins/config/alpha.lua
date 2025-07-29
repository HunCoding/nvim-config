local group = vim.api.nvim_create_augroup("alpha_options", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    command = [[setlocal buflisted fillchars=eob:\ ]],
    desc = "Fix buffer movement, remove eob in alpha.",
    group = group,
    pattern = "alpha",
})
local dashboard = require("alpha.themes.dashboard")
local lazy_stats = require("lazy").stats()
local vim_version = table.concat({ vim.version().major, vim.version().minor, vim.version().patch }, ".")
local highlight = "Alpha"
local function set_button(sc, txt, keybind, keybind_opts)
    local button = dashboard.button(sc, txt, keybind, keybind_opts)
    button.opts.hl = highlight
    button.opts.hl_shortcut = highlight
    return button
end
local header = {
    type = "text",
    val = {
" _   _ _   _ _   _  ____ ___  ____ ___ _   _  ____ ",
        "| | | | | | | \\ | |/ ___/ _ \\|  _ \\_ _| \\ | |/ ___|",
        "| |_| | | | |  \\| | |  | | | | | | | ||  \\| | |  _ ",
        "|  _  | |_| | |\\  | |__| |_| | |_| | || |\\  | |_| |",
        "|_| |_|\\___/|_| \\_|\\____\\___/|____/___|_| \\_|\\____|",
        "                                                   ",
    },
    opts = { position = "center", hl = highlight },
}
local function get_tip()
    local success, tip_text = pcall(vim.fn.system, "curl -s -m 3 https://vtip.43z.one 2>/dev/null")
    if success and tip_text and tip_text ~= "" and not string.match(tip_text, "command not found") then
        tip_text = string.gsub(tip_text, "[\r\n]+", " ")
        tip_text = string.gsub(tip_text, "^%s*(.-)%s*$", "%1")
        return tip_text
    else
        return "Welcome to Neovim!"
    end
end
local tip = {
    type = "text",
    val = { get_tip() },
    opts = { position = "center", hl = highlight },
}
local footer = {
    type = "text",
    val = {
        " " .. lazy_stats.count .. " plugins (" .. lazy_stats.loaded .. " loaded) |  v" .. vim_version,
    },
    opts = { position = "center", hl = highlight },
}
local buttons = {
    type = "group",
    val = {
        set_button("1", "  Load Last Session", "<cmd>SessionManager load_last_session<CR>"),
        set_button("2", "  Browse Sessions", "<cmd>SessionManager load_session<CR>"),
        set_button(
            "3",
            "  Recent Files",
            "<cmd>lua require('user.plugins.config.telescope.sources').frecency()<CR>"
        ),
        set_button("4", "  Find Files", "<cmd>Telescope find_files<CR>"),
        set_button("5", "  New File", "<cmd>enew<CR>"),
        set_button("u", "  Update", "<cmd>Lazy sync<CR>"),
        set_button("q", "  Quit", "<cmd>qa<CR>"),
    },
    opts = {
        spacing = 1,
    },
}
local top_margin_per = 0.2
local header_padding = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * top_margin_per) })
local opts = {
    layout = {
        { type = "padding", val = header_padding },
        header,
        { type = "padding", val = 4 },
        buttons,
        { type = "padding", val = 1 },
        footer,
        tip,
        { type = "padding", val = 1 },
    },
    opts = {
        margin = 5,
    },
}
require("alpha").setup(opts)
