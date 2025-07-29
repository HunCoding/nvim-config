function _G.perform_cleanup()
    local patterns = {
        [[%s/\%^\n//e]],
        [[%s/$\n\+\%$//e]],
        [[%s/\s\+$//e]],
        [[%s/\r\+//e]],
    }
    local view = vim.fn.winsaveview()
    for _, v in pairs(patterns) do
        vim.cmd(string.format("keepjumps keeppatterns silent! %s", v))
    end
    vim.fn.winrestview(view)
end
function _G.launch_ext_prog(prog, ...)
    vim.fn.system(prog .. " " .. table.concat({ ... }, " "))
end
function _G.open_url(url, prefix)
    launch_ext_prog("start", (prefix or "") .. url)
end
function _G.plenary_reload(name)
    local present, plenary = pcall(require, "plenary.reload")
    if not present then
        vim_notify("Plenary not found.", vim.levels.WARN)
        return
    end
    plenary.reload_module(name)
end
function _G.get_module_name(file_path)
    local path_to_lua = CONFIG_PATH .. "\\lua\\"
    local module_name = file_path:gsub(path_to_lua, "")
    if module_name == file_path then
        vim_notify(("Not a valid module (%s)"):format(module_name), vim.log.levels.WARN)
        return
    end
    module_name = module_name:gsub("%.lua", "")
    module_name = module_name:gsub("\\", ".")
    module_name = module_name:gsub("%.init", "")
    return module_name
end
function _G.save_reload_module()
    local file_path = vim.fn.fnameescape(vim.fn.expand("%:p"))
    file_path = file_path:gsub("^%l", string.upper)
    if string.match(file_path, "\\\\") then
        file_path = file_path:gsub("\\\\", "\\")
    end
    vim.cmd("update!")
    if file_path:find("%.vim$") then
        vim.cmd(("source %s"):format(file_path))
        vim_notify(("%s Reloaded."):format(vim.fn.expand("%")), vim.log.levels.INFO)
    else
        local module = get_module_name(file_path)
        if module then
            plenary_reload(module)
            vim.cmd(("source %s"):format(file_path))
            vim_notify(("%s Reloaded."):format(module), vim.log.levels.INFO)
        end
    end
end
function _G.set_title()
    local file = vim.fn.expand("%:p:t")
    local cwd = vim.fn.split(vim.fn.expand("%:p:h"):gsub("/", "\\"), "\\")
    local present, utils = pcall(require, "user.plugins.config.heirline.utils")
    if not present then
        return
    end
    if file ~= "" and not utils.buffer_is_plugin() then
        vim.opt.titlestring = cwd[#cwd] .. "/" .. file
    else
        vim.opt.titlestring = "Neovim"
    end
end
vim.api.nvim_create_user_command("QFix", function(bang)
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 and bang then
        vim.cmd("cclose")
    else
        vim.cmd("copen 10")
    end
end, {
    nargs = "?",
    bang = true,
    force = true,
})
function _G.vim_notify(msg, level)
    vim.cmd("redraw")
    vim.notify(msg, level)
end
function _G.exists_and_not_nil(t)
    if t then
        return next(t) ~= nil
    end
    return false
end
