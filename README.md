# csvlens.nvim

A way to easily preview CSV files directly in neovim. Backed by [YS-L/csvlens](https://github.com/YS-L/csvlens).

## Notes

Requires Neovim version 0.7.0 or greater.
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

## Alternatives

[VidocqH/data-viewer.nvim](https://github.com/VidocqH/data-viewer.nvim)
- This plugin supports sqlite as well
- However, I don't like how the UI looks. csvlens looks much better to me, which is why I wanted to make this port.

## Credits

The automatic download script was taken from [ellisonleao/glow.nvim](https://github.com/ellisonleao/glow.nvim).
