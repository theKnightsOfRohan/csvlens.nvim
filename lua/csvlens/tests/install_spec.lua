local Installer = require("csvlens.install")

local temp_install_path = os.getenv("INSTALLER_DIR") or "/tmp/csvlens_test/installer_test/"

describe("Installer", function()
    it(" should be able to set custom install path", function()
        Installer:_set_install_path(temp_install_path)
        assert.are.equal(Installer._install_path, temp_install_path)
    end)
end)
