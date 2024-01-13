local Terminal = require("toggleterm.terminal").Terminal

---@class csvlens
---@field config CsvlensConfig
---@field verified boolean
---@field setup function
---@field open_csv function
---@field check_if_installed function
---@field construct_cmd function
---@field ends_with function
local Csvlens = {}

---@class CsvlensConfig
---@field direction string "vertical" | "horizontal" | "tab" | "float",
Csvlens.config = {
    direction = "float",
}

Csvlens.verified = false

---@param config CsvlensConfig
---@return nil
function Csvlens.setup(config)
    Csvlens.config = vim.tbl_deep_extend("force", Csvlens.config, config or {})

    Csvlens.verified = Csvlens.check_if_installed()

    if not Csvlens.verified then
        local install = vim.fn.input("csvlens not found in PATH. Install automatically? (y/n): ")

        if install ~= "y" then
            print("csvlens can be installed at https://github.com/YS-L/csvlens")
            print("If you have already installed csvlens, please add it to your PATH.")
            return
        end

        print("Installing csvlens...")
        require("csvlens.install"):install_csvlens()
    end

    vim.api.nvim_create_user_command("Csvlens", Csvlens.open_csv, {})
end

---@return nil
function Csvlens.open_csv()
    if not Csvlens.verified then
        print("csvlens tool is not installed or not in your PATH.")
        print("Install at https://github.com/YS-L/csvlens")
        return
    end

    local file_to_open = vim.fn.expand("%:p")
    local constructed_cmd = Csvlens.construct_cmd("csvlens", file_to_open)
    if not constructed_cmd then
        vim.api.nvim_err_writeln("ERROR: " .. file_to_open .. " is not a csv file.")
        return
    end

    local csvlens = Terminal:new({
        cmd = constructed_cmd,
        close_on_exit = true,
        direction = Csvlens.config.direction,
    })
    csvlens:toggle()
end

---@param str string the string we are testing
---@param ending string the ending we are testing for
function Csvlens.ends_with(str, ending)
    return ending == "" or str:sub(- #ending) == ending
end

---@param cmd string
---@param file string
function Csvlens.construct_cmd(cmd, file)
    if not Csvlens.ends_with(file, ".csv") then
        return nil
    end
    return cmd .. " " .. file
end

---@return boolean installed
function Csvlens.check_if_installed()
    return vim.fn.executable("csvlens") == 1
end

return Csvlens
