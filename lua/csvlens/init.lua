local UI = require("csvlens.ui")
local Utils = require("csvlens.utils")
local Installer = require("csvlens.installer")

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

    vim.api.nvim_create_user_command("Csvlens", function(opts)
        Csvlens.open_csv(opts)
    end, {})
end

---@class CommandArgs
---@field fargs string[] Should be a list of length 1, containing the delimiter

---@param command_args CommandArgs
function Csvlens.open_csv(command_args)
    if not Csvlens.verified then
        Installer:install_flow()
    end

    local delimiter = command_args.fargs[1]
    local file_to_open = vim.fn.expand("%:p")
    local constructed_cmd = Utils.construct_cmd("csvlens", file_to_open, delimiter)
    if not constructed_cmd then
        vim.api.nvim_err_writeln(
            "ERROR: " .. file_to_open .. " is not a csv or tsv file, or a delimiter was not provided."
        )
        return
    end

    UI.open(constructed_cmd, Csvlens.config)
end

return Csvlens
