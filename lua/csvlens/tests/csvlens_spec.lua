require("plenary.reload").reload_module("csvlens", true)

local csvlens = require("csvlens")

describe("Setup ", function()
    it("with default configs", function()
        local expected = {
            direction = "float",
            exec_path = "csvlens",
        }
        csvlens.setup()
        assert.are.same(csvlens.config, expected)
    end)

    it("with custom configs", function()
        local expected = {
            direction = "vertical",
            exec_path = "/usr/bin/csvlens",
        }
        csvlens.setup(expected)
        assert.are.same(csvlens.config, expected)
    end)

    it("with partial configs", function()
        local expected = {
            direction = "vertical",
            exec_path = "csvlens",
        }
        csvlens.setup({ direction = "vertical" })
        assert.are.same(csvlens.config, expected)
    end)
end)
