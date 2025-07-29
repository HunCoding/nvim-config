vim.g.mapleader = ","
vim.opt.fileencoding = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.viewoptions:remove("options")
vim.opt.foldmethod = "marker"
vim.opt.list = true
vim.opt.fillchars = {
    eob = "–",
    fold = " ",
    foldsep = " ",
    foldclose = "",
    foldopen = "",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    stl = "─",
    stlnc = "─",
}
vim.opt.listchars:append({ tab = " ", lead = "·", trail = "·", eol = "﬋" })
vim.opt.spelllang = "en_us"
vim.opt.laststatus = 3
vim.opt.foldcolumn = "auto:9"
vim.opt.signcolumn = "yes"
vim.opt.lazyredraw = true
vim.opt.mouse = "nv"
vim.opt.scrolloff = 8
vim.opt.shortmess = "ilmxoOsTIcF"
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.inccommand = "split"
vim.opt.title = true
vim.opt.startofline = false
vim.opt.wildignore = {
    "*.aux",
    "*.lof",
    "*.lot",
    "*.fls",
    "*.out",
    "*.toc",
    "*.fmt",
    "*.fot",
    "*.cb",
    "*.cb2",
    ".*.lb",
    "__latex*",
    "*.fdb_latexmk",
    "*.synctex",
    "*.synctex(busy)",
    "*.synctex.gz",
    "*.synctex.gz(busy)",
    "*.pdfsync",
    "*.bbl",
    "*.bcf",
    "*.blg",
    "*.run.xml",
    "indent.log",
    "*.pdf",
}
local undo_dir = vim.fn.expand("~/.cache/vim/undo")
if not vim.fn.isdirectory(undo_dir) then
    vim.fn.mkdir(undo_dir, "p")
end
vim.opt.undodir = undo_dir
vim.opt.undofile = true
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/venv/bin/python")
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "matchit",
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
