---@class Installer
---@field install_flow function
---@field _install_path string
---@field _release_file_url function
---@field _install_csvlens function
local Installer = {}

function Installer:install_flow()
    local install = vim.fn.input("csvlens not found in PATH. Install automatically? (y/n): ")

    if install == "y" then
        print("Installing csvlens...")
        self:_install_csvlens()
    elseif install ~= "n" then
        print("csvlens can be installed at https://github.com/YS-L/csvlens")
        print("If you have already installed csvlens, please add it to your PATH.")
    else
        print("Input not recognized.")
    end
end

Installer._install_path = vim.env.HOME .. "/.local/bin"

---@return string
function Installer._release_file_url()
    local os, arch
    local version = "0.6.0"

    -- check pre-existence of required programs
    if vim.fn.executable("curl") == 0 or vim.fn.executable("tar") == 0 then
        vim.api.nvim_err_writeln("ERROR: both curl and tar are required to install csvlens automatically")
        return ""
    end

    -- local raw_os = jit.os
    local raw_os = vim.loop.os_uname().sysname
    local raw_arch = jit.arch
    local os_patterns = {
        ["Windows"] = "pc-windows-msvc",
        ["Windows_NT"] = "pc-windows-msvc",
        ["Linux"] = "unknown_linux_gnu",
        ["Darwin"] = "apple_darwin",
    }

    local arch_patterns = {
        ["x64"] = "x86_64",
        ["arm64"] = "aarch64",
    }

    os = os_patterns[raw_os]
    arch = arch_patterns[raw_arch]

    if os == nil or arch == nil then
        vim.api.nvim_err_writeln("ERROR: os not supported or could not be parsed")
        return ""
    end

    -- create the url, filename based on os and arch
    local filename = "csvlens-" .. arch .. "-" .. os .. (os == "Windows" and ".zip" or ".tar.xz")
    return "https://github.com/YS-L/csvlens/releases/download/v" .. version .. "/" .. filename
end

function Installer:_install_csvlens()
    local release_url = self._release_file_url()
    if release_url == "" then
        return
    end

    local download_command = { "curl", "-sL", "-o", "csvlens.tar.xz", release_url }
    local extract_command = { "tar", "-zxf", "csvlens.tar.xz", "-C", self._install_path }
    local output_filename = "csvlens.tar.xz"
    ---@diagnostic disable-next-line: missing-parameter
    local binary_path = vim.fn.expand(table.concat({ self._install_path, "csvlens" }, "/"))

    -- check for existing files / folders
    if vim.fn.isdirectory(self._install_path) == 0 then
        vim.loop.fs_mkdir(self._install_path, tonumber("777", 8))
    end

    ---@diagnostic disable-next-line: missing-parameter
    if vim.fn.filereadable(binary_path) == 1 then
        local success = vim.loop.fs_unlink(binary_path)
        if not success then
            vim.api.nvim_err_writeln("ERROR: csvlens binary could not be removed")
            return
        end
    end

    -- download and install the csvlens binary
    local callbacks = {
        on_sterr = vim.schedule_wrap(function(_, data, _)
            local out = table.concat(data, "\n")
            vim.api.nvim_err_writeln(out)
        end),
        on_exit = vim.schedule_wrap(function()
            vim.fn.system(extract_command)
            -- remove the archive after completion
            if vim.fn.filereadable(output_filename) == 1 then
                local success = vim.loop.fs_unlink(output_filename)
                if not success then
                    vim.api.nvim_err_writeln("ERROR: existing archive could not be removed")
                    return
                end
            end
        end),
    }
    vim.fn.jobstart(download_command, callbacks)
end

return Installer
