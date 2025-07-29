local utils = require("user.plugins.config.telescope.utils")
local file_sorter = utils.file_sorter
local dropdown = utils.dropdown
local M = {}
M.dir_nvim = function()
    local opts = {
        cwd = CONFIG_PATH,
        prompt_title = "Neovim",
        no_ignore = true,
    }
    require("telescope.builtin").find_files(opts)
end
M.dir_plugins = function()
    local opts = {
        cwd = LAZY_PATH,
        file_ignore_patterns = vim.list_extend({ "test\\" }, utils.ignore_patterns),
        prompt_title = "Plugin Files",
    }
    require("telescope.builtin").find_files(opts)
end
M.reload_modules = function()
    local actions_state = require("telescope.actions.state")
    local cwd = CONFIG_PATH .. "\\lua\\"
    local opts = {
        cwd = cwd,
        prompt_title = "Reload Neovim Modules",
        sorter = file_sorter({ "%.lua$" }),
        attach_mappings = function(prompt_bufnr, map)
            local reload_module_map = function(should_close)
                local entry = actions_state.get_selected_entry()
                local name = get_module_name(cwd .. entry.value:gsub("^%.\\", ""))
                if should_close then
                    require("telescope.actions").close(prompt_bufnr)
                end
                plenary_reload(name)
                vim_notify(("%s Reloaded."):format(name), vim.log.levels.INFO)
            end
            require("telescope.actions.set").select:replace(function()
                reload_module_map(true)
            end)
            map("i", "<C-r>", function()
                reload_module_map()
            end)
            return true
        end,
    }
    require("telescope.builtin").find_files(opts)
end
M.frecency = function()
    local frecency_opts = dropdown({ prompt_title = "Recent Files", path_display = { "absolute" } })
    require("telescope").extensions.frecency.frecency(frecency_opts)
end
M.git_or_find = function()
    local opts = dropdown({ prompt_title = "Find Files" })
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then
        require("telescope.builtin").find_files(opts)
    end
end
return M
