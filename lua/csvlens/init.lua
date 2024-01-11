local Terminal = require('toggleterm.terminal').Terminal

local M = {}

---@param str string the string we are testing
---@param ending string the ending we are testing for
function M.ends_with(str, ending)
    return ending == "" or str:sub(- #ending) == ending
end

---@param cmd string
---@param file string
function M.construct_cmd(cmd, file)
    if not M.ends_with(file, '.csv') then
        return nil
    end
    return cmd .. ' ' .. file
end

M.verified = false

function M.open_csv()
    if not M.verified then
        print('csvlens tool is not installed or not in your PATH.')
        print('Install at https://github.com/YS-L/csvlens')
        return
    end

    local file_to_open = vim.fn.expand('%:p')
    local constructed_cmd = M.construct_cmd('csvlens', file_to_open)
    if not constructed_cmd then
        vim.err("ERROR: " .. file_to_open .. " is not a csv file.")
        return
    end

    local csvlens = Terminal:new({
        cmd = constructed_cmd,
        close_on_exit = true,
        direction = 'float',
    })
    csvlens:toggle()
end

function M.check_if_installed()
    return vim.fn.executable('csvlens') == 1
end

function M.setup()
    M.verified = M.check_if_installed()

    if not M.verified then
        local install = vim.fn.input("csvlens not found in PATH. Install automatically? (y/n): ")

        if (install ~= 'y') then
            print("csvlens can be installed at https://github.com/YS-L/csvlens")
            print("If you have already installed csvlens, please add it to your PATH.")
            return
        end

        print("Installing csvlens...")
        require("csvlens.install"):install_csvlens()
    end

    vim.api.nvim_create_user_command('Csvlens', M.open_csv, {})
end

return M
