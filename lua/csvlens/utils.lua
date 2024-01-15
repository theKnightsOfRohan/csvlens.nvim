---@class Utils
---@field ends_with function
---@field construct_cmd function
---@field check_if_installed function
local Utils = {}

---@param str string the string we are testing
---@param ending string the ending we are testing for
function Utils.ends_with(str, ending)
    return ending == "" or str:sub(- #ending) == ending
end

---@param cmd string
---@param file string
function Utils.construct_cmd(cmd, file)
    if not Utils.ends_with(file, ".csv") then
        return nil
    end
    return cmd .. " " .. file
end

---@return boolean installed
function Utils.check_if_installed()
    return vim.fn.executable("csvlens") == 1
end

return Utils
