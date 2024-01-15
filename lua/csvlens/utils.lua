---@class Utils
---@field _ends_with function
---@field _construct_cmd function
---@field _check_if_installed function
local Utils = {}

---@param str string the string we are testing
---@param ending string the ending we are testing for
function Utils._ends_with(str, ending)
    return ending == "" or str:sub(- #ending) == ending
end

---@param cmd string
---@param file string
---@param delimiter string
---@return string | nil
function Utils._construct_cmd(cmd, file, delimiter)
    if delimiter ~= nil then
        return cmd .. " " .. file .. " -d " .. delimiter
    elseif Utils._ends_with(file, ".csv") then
        return cmd .. " " .. file
    elseif Utils._ends_with(file, ".tsv") then
        return cmd .. " " .. file .. " -t"
    end

    return nil
end

---@param exec string
---@return boolean installed
function Utils._check_if_installed(exec)
    return vim.fn.executable(exec) == 1
end

return Utils
