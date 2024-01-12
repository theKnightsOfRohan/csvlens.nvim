# csvlens.nvim

A way to easily preview CSV files directly in neovim, similar to glow.nvim. Backed by [YS-L/csvlens](https://github.com/YS-L/csvlens).

## Notes

This plugin depends on [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) as the UI for the previewer.

## Quickstart

### lazy.nvim installation
```lua
return {
    "theKnightsOfRohan/csvlens.nvim",
    dependencies = {
        "akinsho/toggleterm.nvim"
    },
    config = function()
        require("toggleterm").setup()
        require("csvlens").setup()
    end,
}
```

## Config

This plugin requires you to have [csvlens](https://github.com/YS-L/csvlens) installed and in your PATH. You can install it automatically with this plugin, and it will be installed in $HOME/.local/bin, or you could install it using your package manager of choice.

## Usage

This plugin is designed to be simple and easy to use. Simply open the csv file that you want to preview, then use the command `:Csvlens` to open a floating window with the preview of the opened file. The keyboard commands are the same as csvlens's defaults.
