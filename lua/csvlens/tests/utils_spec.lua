local utils = require("csvlens.utils")

describe("Utils", function()
    it("should be able to correctly identify ends_with", function()
        assert.is_true(utils.ends_with("hello", "lo"))
        assert.is_false(utils.ends_with("hello", "l"))
        assert.is_false(utils.ends_with("hello", "hello world"))
    end)

    it("should be able to correctly construct commands", function()
        local cmd = "csvlens"
        local csv_file = "test.csv"
        local tsv_file = "test.tsv"
        local txt_file = "test.txt"
        local delimiter = ";"

        assert.are.same("csvlens test.csv", utils.construct_cmd(cmd, csv_file, nil))
        assert.are.same("csvlens test.tsv -t", utils.construct_cmd(cmd, tsv_file, nil))
        assert.are.same("csvlens test.txt -d ;", utils.construct_cmd(cmd, txt_file, delimiter))
    end)
end)
