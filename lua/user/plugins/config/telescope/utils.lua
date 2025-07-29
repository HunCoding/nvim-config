local M = {}
M.ignore_patterns = {
    ".git\\",
    "TAGS",
    "%.TAGS",
    "tags",
    "%.tags",
    "gtags%.files",
    "GTAGS",
    "GRTAGS",
    "GPATH",
    "GSYMS",
    "cscope%.files",
    "cscope%.out",
    "cscope%.in%.out",
    "cscope%.po%.out",
    "__pycache__\\",
    ".*%.py[cod]",
    ".*$py%.class",
    "%.Python",
    "build\\",
    "develop-eggs\\",
    "dist\\",
    "downloads\\",
    "eggs\\",
    "%.eggs\\",
    "lib\\",
    "lib64\\",
    "parts\\",
    "sdist\\",
    "var\\",
    "wheels\\",
    "share\\python-wheels\\",
    ".*%.egg-info\\",
    "%.installed%.cfg",
    ".*%.egg",
    "MANIFEST",
    "%.env",
    "%.venv",
    "env\\",
    "venv\\",
    "ENV\\",
    "env%.bak\\",
    "venv%.bak\\",
    "%.jpg",
    "%.jpeg",
    "%.jpe",
    "%.jif",
    "%.jfif",
    "%.jfi",
    "%.jp2",
    "%.j2k",
    "%.jpf",
    "%.jpx",
    "%.jpm",
    "%.mj2",
    "%.jxr",
    "%.hdp",
    "%.wdp",
    "%.gif",
    "%.raw",
    "%.webp",
    "%.png",
    "%.apng",
    "%.mng",
    "%.tiff",
    "%.tif",
    "%.svg",
    "%.svgz",
    "%.pdf",
    "%.xbm",
    "%.bmp",
    "%.dib",
    "%.ico",
    "%.3dm",
    "%.max",
    "%.fnt",
    "%.fon",
    "%.otf",
    "%.ttf",
    "%.woff",
    "%.woff2",
    "%.fdb_latexmk",
    "%.synctex",
    "%.synctex%(busy%)",
    "%.synctex%.gz",
    "%.synctex%.gz%(busy%)",
    "%.pdfsync",
}
M.dropdown = function(opts)
    opts = opts or {}
    local theme_opts = {
        theme = "dropdown",
        previewer = false,
        results_title = false,
        sorting_strategy = "ascending",
        layout_strategy = "center",
        layout_config = {
            width = function(_, max_columns, _)
                return math.min(max_columns - 10, 100)
            end,
            height = function(_, _, max_lines)
                return math.min(max_lines, 20)
            end,
        },
        border = true,
        borderchars = {
            { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
    }
    return vim.tbl_deep_extend("force", theme_opts, opts)
end
M.file_sorter = function(whitelist)
    local sorter = require("telescope.sorters").get_fuzzy_file()
    sorter._was_discarded = function()
        return false
    end
    sorter.filter_function = function(_, prompt, entry)
        for _, v in ipairs(whitelist) do
            if entry.value:find(v) then
                return 0, prompt
            end
        end
        return -1, prompt
    end
    return sorter
end
return M
