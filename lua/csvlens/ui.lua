local Terminal = require("toggleterm.terminal").Terminal

---@class CsvlensUI
---@field open function
local CsvlensUI = {}

---@param constructed_cmd string the command to run when opening the terminal
---@param config table the configuration for the terminal
function CsvlensUI.open(constructed_cmd, config)
    local csvlens = Terminal:new({
        cmd = constructed_cmd,
        close_on_exit = true,
        direction = config.direction,
    })
    csvlens:toggle()
end

return CsvlensUI
