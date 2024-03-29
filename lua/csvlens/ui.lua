local Terminal = require("toggleterm.terminal").Terminal

---@class CsvlensUI
---@field open function
local UI = {}

---@param constructed_cmd string the command to run when opening the terminal
---@param config table the configuration for the terminal
function UI.open(constructed_cmd, config)
    local csvlens_window = Terminal:new({
        cmd = constructed_cmd,
        close_on_exit = true,
        direction = config.direction,
    })
    csvlens_window:toggle()
end

return UI
