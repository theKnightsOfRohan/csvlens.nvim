local Utils = require("csvlens.utils")

describe("Utils", function()
    it("should be able to correctly identify ends_with", function()
        assert.is_true(Utils._ends_with("hello", "lo"))
        assert.is_false(Utils._ends_with("hello", "l"))
        assert.is_false(Utils._ends_with("hello", "hello world"))
    end)

    it("should be able to correctly construct commands", function()
        local cmd = "csvlens"
        local csv_file = "test.csv"
        local tsv_file = "test.tsv"
        local txt_file = "test.txt"
        local delimiter = ";"

        assert.are.same("csvlens test.csv", Utils._construct_cmd(cmd, csv_file, nil))
        assert.are.same("csvlens test.tsv -t", Utils._construct_cmd(cmd, tsv_file, nil))
        assert.are.same("csvlens test.txt -d ;", Utils._construct_cmd(cmd, txt_file, delimiter))
    end)
end)
