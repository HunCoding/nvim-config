SCHEME = "jellybeans"
SERVERS = { "pyright", "lua_ls", "omnisharp", "html", "cssls", "eslint", "emmet_ls", "ruff", "gopls", "yamlls" }
PARSERS = { "comment", "python", "lua", "c_sharp", "html", "css", "javascript", "yaml", "json", "markdown", "vim", "go" }
PLUGINS = { "alpha", "neo-tree" }
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
LAZY_PATH = vim.fn.stdpath("data") .. "/lazy"
ICON_ERROR = "E"
ICON_WARN = "W"
ICON_INFO = "I"
ICON_HINT = "H"
vim.cmd("source ~/.config/nvim/viml/utils.vim")
vim.cmd("source ~/.config/nvim/viml/autocommands.vim")
require("user.autocmds")
require("user.options")
require("user.utils")
require("user.mappings")
require("user.plugins")
