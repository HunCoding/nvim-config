require("jaq-nvim").setup({
    cmds = {
        internal = {
            lua = 'luafile "$filePath"',
            vim = 'source "$filePath"',
        },
        external = {
            python = 'py -u "$filePath"',
            cs = "dotnet run",
        },
    },
    behavior = {
        default = "float",
        startinsert = false,
        wincmd = false,
        autosave = false,
    },
    ui = {
        float = {
            border = "single",
            winhl = "Normal",
            borderhl = "FloatBorder",
            winblend = 0,
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
        },
        terminal = {
            position = "bot",
            size = 15,
            line_no = true,
        },
        quickfix = {
            position = "bot",
            size = 10,
        },
    },
})
