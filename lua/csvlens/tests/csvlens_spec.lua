require("plenary.reload").reload_module("csvlens", true)

local csvlens = require("csvlens")

describe("Setup ", function()
    it("with default configs", function()
        local expected = {
            direction = "float",
            exec_path = "csvlens",
            exec_install_path = vim.fn.stdpath("data") .. "/csvlens.nvim/",
        }
        csvlens.setup()
        assert.are.same(csvlens.config, expected)
    end)

    it("with custom configs", function()
        local expected = {
            direction = "vertical",
            exec_path = "/usr/bin/csvlens",
            exec_install_path = "/tmp/csvlens/",
        }
        csvlens.setup(expected)
        assert.are.same(csvlens.config, expected)
    end)

    it("with partial configs", function()
        local expected = {
            direction = "vertical",
            exec_path = "csvlens",
            exec_install_path = vim.fn.stdpath("data") .. "/csvlens.nvim/",
        }
        csvlens.setup({ direction = "vertical" })
        assert.are.same(csvlens.config, expected)
    end)
end)
