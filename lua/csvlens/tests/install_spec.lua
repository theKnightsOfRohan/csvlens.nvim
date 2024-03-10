local Installer = require("csvlens.install")

local temp_install_path = "/tmp/csvlens_test/installer_test/"

describe("Installer", function()
    it(" should be able to set custom install path", function()
        Installer:_set_install_path(temp_install_path)
        assert.are.equal(Installer._install_path, temp_install_path)
    end)

    it(" should be able to install csvlens", function()
        Installer:_set_install_path(temp_install_path)
        assert.are.equal(Installer._install_path, temp_install_path)

        local ok = Installer:_install_csvlens()

        local expected_exec_path = temp_install_path .. "csvlens"
        local expected_version = "csvlens 0.7.0\n"

        assert.are.equal(ok, true)
        assert.are.equal(vim.fn.executable(expected_exec_path), 1)
        assert.are.equal(vim.fn.system(temp_install_path .. "csvlens --version"), expected_version)
    end)
end)
