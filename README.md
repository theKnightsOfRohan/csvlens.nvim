# csvlens.nvim

A way to easily preview CSV files directly in neovim using csvlens, similar to glow.nvim. 

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
    config = {
        require("toggleterm").setup()
        require("csvlens").setup()
    }
}
```

## Config

This plugin requires you to have [csvlens](https://github.com/YS-L/csvlens) installed and in your PATH. You can install it automatically with this plugin, and it will be installed in $HOME/.local/bin, or you could install it using your package manager of choice.
