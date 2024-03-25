---@class CsvlensInstaller
---@field install_flow function
---@field _install_path string
---@field _set_install_path function
---@field _construct_release_file_url function
---@field _install_csvlens function
local Installer = {}

---The user prompting flow for installing csvlens
---@param self CsvlensInstaller
function Installer:install_flow()
    local install = vim.fn.input("csvlens not found in PATH. Install automatically? (y/n): ")

    if install == "y" then
        print("Installing csvlens...")
        local ok, msg = self:_install_csvlens()
        if not ok then
            vim.api.nvim_err_writeln(msg)
        else
            print(msg)
        end
    elseif install == "n" then
        print("csvlens can be installed at https://github.com/YS-L/csvlens")
        print("If you have already installed csvlens, please add it to your PATH.")
    else
        print("Input not recognized.")
    end
end

Installer._install_path = vim.env.HOME .. "/.local/bin/"

---@param self CsvlensInstaller
---@param path string
function Installer:_set_install_path(path)
    self._install_path = path
end

---This function will construct the url for the csvlens release file
---This allows the plugin to be installed on any platform
---@return string url_base
---@return string filename
---@return string foldername
function Installer._construct_release_file_url()
    local os, arch
    local version = "0.8.1"

    -- check pre-existence of required programs
    if vim.fn.executable("curl") == 0 or vim.fn.executable("tar") == 0 then
        vim.api.nvim_err_writeln("ERROR: both curl and tar are required to install the csvlens binary automatically")
        return "", "", ""
    end

    -- local raw_os = jit.os
    local raw_os = vim.loop.os_uname().sysname
    local raw_arch = jit.arch
    local os_patterns = {
        ["Windows"] = "pc-windows-msvc",
        ["Windows_NT"] = "pc-windows-msvc",
        ["Linux"] = "unknown-linux-gnu",
        ["Darwin"] = "apple-darwin",
    }

    local arch_patterns = {
        ["x64"] = "x86_64",
        ["arm64"] = "aarch64",
    }

    os = os_patterns[raw_os]
    arch = arch_patterns[raw_arch]

    if os == nil or arch == nil then
        vim.api.nvim_err_writeln("ERROR: os not supported or could not be parsed")
        return "", "", ""
    end

    -- create the url, filename based on os and arch
    local foldername = "csvlens-" .. arch .. "-" .. os
    local filename = foldername .. (os == "Windows" and ".zip" or ".tar.xz")
    return "https://github.com/YS-L/csvlens/releases/download/v" .. version .. "/", filename, foldername
end

---This function will install the csvlens binary, extract it, and remove the archive
---@param self CsvlensInstaller
---@return boolean ok
---@return string err
function Installer:_install_csvlens()
    local release_url, filename, foldername = self._construct_release_file_url()
    if release_url == "" then
        return false, "ERROR: release url could not be constructed"
    end

    local download_command = { "curl", "-sL", "-o", self._install_path .. filename, release_url .. filename }
    local extract_command = { "tar", "-xvf", self._install_path .. filename, "-C", self._install_path }
    local move_command = { "mv", self._install_path .. foldername .. "/csvlens", self._install_path }
    local cleanup_command = { "rm", "-rf", self._install_path .. foldername, ";", "rm", self._install_path .. filename }

    local binary_path = vim.fn.expand(self._install_path .. "csvlens")

    -- check for existing files / folders
    if vim.fn.isdirectory(self._install_path) == 0 then
        vim.loop.fs_mkdir(self._install_path, tonumber("777", 8))
    end

    if vim.fn.filereadable(binary_path) == 1 then
        local success = vim.loop.fs_unlink(binary_path)
        if not success then
            return false, "ERROR: old csvlens binary could not be removed"
        end
    end

    local res = vim.fn.system(download_command)

    if vim.fn.filereadable(self._install_path .. filename) == 0 then
        return false, "ERROR: csvlens binary could not be downloaded\r\n" .. "ERROR CODE: " .. res
    end

    res = vim.fn.system(extract_command)

    if vim.fn.isdirectory(self._install_path .. foldername) == 0 then
        return false, "ERROR: csvlens binary could not be extracted\r\n" .. "ERROR CODE: " .. res
    end

    res = vim.fn.system(move_command)

    if vim.fn.filereadable(binary_path) == 0 then
        return false, "ERROR: csvlens binary could not be moved\r\n" .. "ERROR CODE: " .. res
    end

    res = vim.fn.system(cleanup_command)

    if vim.fn.isdirectory(self._install_path .. foldername) == 1 then
        return false, "ERROR: csvlens archive could not be removed\r\n" .. "ERROR CODE: " .. res
    end

    return true, "Csvlens has been installed successfully!"
end

return Installer
