local UI = require("csvlens.ui")
local Utils = require("csvlens.utils")
local Installer = require("csvlens.install")

---@class Csvlens
---@field _config CsvlensConfig
---@field _verified boolean
---@field setup function
---@field open_csv function
local Csvlens = {}

---@class CsvlensConfig
---@field direction string "vertical" | "horizontal" | "tab" | "float",
---@field exec_path string
---@field exec_install_path string directory to install the executable to, ends with /
Csvlens._config = {
    direction = "float",
    exec_path = "csvlens",
    exec_install_path = vim.fn.stdpath("data") .. "/csvlens.nvim/",
}

Csvlens._verified = false

---@param new_config CsvlensConfig
function Csvlens.setup(new_config)
    Csvlens._config = vim.tbl_deep_extend("force", Csvlens._config, new_config or {})

    Csvlens._verified = Utils._check_if_installed(Csvlens._config.exec_path)

    if not Csvlens._verified then
        Csvlens._verified = Utils._check_if_installed(Csvlens._config.exec_install_path .. "csvlens")

        if not Csvlens._verified then
            Installer:_set_install_path(Csvlens._config.exec_install_path)
        else
            Csvlens._config.exec_path = Csvlens._config.exec_install_path .. "csvlens"
        end
    end

    vim.api.nvim_create_user_command("Csvlens", function(opts)
        Csvlens.open_csv(opts)
    end, {})
end

---@class CommandArgs
---@field fargs string[] Should be a list of length 1, containing the delimiter

---@param self Csvlens
---@param command_args CommandArgs
function Csvlens:open_csv(command_args)
    if not self._verified then
        Installer:install_flow()
    end

    local delimiter = command_args.fargs[1]
    local file_to_open = vim.fn.expand("%:p")
    local constructed_cmd = Utils:_construct_cmd(self._config.exec_path, file_to_open, delimiter)
    if not constructed_cmd then
        vim.api.nvim_err_writeln(
            "ERROR: " .. file_to_open .. " is not a csv or tsv file, or a delimiter was not provided."
        )
        return
    end

    UI.open(constructed_cmd, self._config)
end

return Csvlens
