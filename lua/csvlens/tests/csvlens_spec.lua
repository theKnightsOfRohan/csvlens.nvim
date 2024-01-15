-- require("toggleterm").setup()
-- require("plenary.reload").reload_module("csvlens", true)

-- local csvlens = require("csvlens")

describe("setup", function()
    --[[ it("setup with default configs", function()
        local expected = {
            direction = "float",
        }
        csvlens.setup()
        assert.are.same(csvlens.config, expected)
    end)

    it("setup with custom configs", function()
        local expected = {
            direction = "vertical",
        }
        csvlens.setup(expected)
        assert.are.same(csvlens.config, expected)
    end) ]]
end)
