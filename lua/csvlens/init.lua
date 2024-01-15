local Terminal = require("toggleterm.terminal").Terminal
local Utils = require("csvlens.utils")

---@class Csvlens
---@field config CsvlensConfig
---@field verified boolean
---@field setup function
---@field open_csv function
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

    Csvlens.verified = Utils.check_if_installed()

    vim.api.nvim_create_user_command("Csvlens", function(opts) Csvlens.open_csv(opts) end, {})
end

---@class CommandArgs
---@field fargs string[] Should be a list of length 1, containing the delimiter

---@param command_args CommandArgs
---@return nil
function Csvlens.open_csv(command_args)
    if not Csvlens.verified then
        local install = vim.fn.input("csvlens not found in PATH. Install automatically? (y/n): ")

        if install == "y" then
            print("Installing csvlens...")
            require("csvlens.install"):install_csvlens()
        elseif install ~= "n" then
            print("csvlens can be installed at https://github.com/YS-L/csvlens")
            print("If you have already installed csvlens, please add it to your PATH.")
        else
            print("Input not recognized.")
        end
    else
        local delimiter = command_args.fargs[1]
        local file_to_open = vim.fn.expand("%:p")
        local constructed_cmd = Utils.construct_cmd("csvlens", file_to_open, delimiter)
        if not constructed_cmd then
            vim.api.nvim_err_writeln(
                "ERROR: " .. file_to_open .. " is not a csv or tsv file, or a delimiter was not provided."
            )
            return
        end

        local csvlens = Terminal:new({
            cmd = constructed_cmd,
            close_on_exit = true,
            direction = Csvlens.config.direction,
        })
        csvlens:toggle()
    end
end

return Csvlens
