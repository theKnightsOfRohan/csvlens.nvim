---@class CsvlensUtils
---@field _ends_with function
---@field _construct_cmd function
---@field _check_if_installed function
local Utils = {}

---@param str string the string we are testing
---@param ending string the ending we are testing for
function Utils._ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

---@param self CsvlensUtils
---@param cmd string
---@param file string
---@param delimiter string
---@return string | nil
function Utils:_construct_cmd(cmd, file, delimiter)
    cmd = vim.fn.fnameescape(cmd)
    file = vim.fn.fnameescape(file)
    if delimiter ~= nil then
        return string.format("%s %s -d %s", cmd, file, delimiter)
    elseif self._ends_with(file, ".csv") then
        return string.format("%s %s", cmd, file)
    elseif self._ends_with(file, ".tsv") then
        return string.format("%s %s -t", cmd, file)
    end

    return nil
end

---@param exec string
---@return boolean installed
function Utils._check_if_installed(exec)
    return vim.fn.executable(exec) == 1
end

return Utils
