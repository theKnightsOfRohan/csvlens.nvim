# csvlens.nvim

A way to easily preview CSV files, as well as other separated filetypes, directly in neovim. Backed by [YS-L/csvlens](https://github.com/YS-L/csvlens).

https://github.com/theKnightsOfRohan/csvlens.nvim/assets/114779675/07cf5178-4231-4515-8c35-0b2027f76ae8

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
    config = true,
    opts = { --[[ Place your opts here ]] }
}
```

### Config

This plugin requires you to have [csvlens](https://github.com/YS-L/csvlens) installed and in your PATH. You can install it automatically with this plugin, and it will be installed in $HOME/.local/bin, or you could install it using your terminal package manager of choice. You can also manually specify the path of the executable as part of the configuration.

A default config will contain the following:
```lua
require("csvlens").setup({
    direction = "float", -- "float" | "vertical" | "horizontal" |  "tab"
    exec_path = "csvlens", -- You can specify the path to the executable if you wish. Otherwise, it will use the command in the PATH.
    exec_install_path = vim.fn.stdpath("data") .. "/csvlens.nvim/", -- directory to install the executable to if it's not found in the exec_path, ends with /
})
```

The `exec_path` is prioritized as the executable location, with the `exec_install_path` as a backup. If it is not found in either location, the executable will be installed.

Due to the way the toggleterm API works, the csvlens preview config will take precedence over the toggleterm config for csvlens's previews.

## Usage

This plugin is designed to be simple and easy to use. Open the csv file that you want to preview, then use the command `:Csvlens` to open a window with the preview of the opened table. The keyboard commands in this window are the same as csvlens's. Typing `H` in the preview will open up the help menu for csvlens, where you can find the keybindings.

You can also open a file with custom delimiters by passing them as string arguments to the command. For example, `:Csvlens "$"` would open the preview as if the open file were separated by `$`. All separators must be one character, with the exception of `\t`. However, this plugin will automatically use tabs as the delimiter if opening a tsv file.

## Alternatives

[VidocqH/data-viewer.nvim](https://github.com/VidocqH/data-viewer.nvim)
- This plugin supports sqlite as well
- However, I don't like how the UI looks. csvlens looks much better to me, which is why I wanted to make this port.

## Credits

The automatic download script was taken and built off of from [ellisonleao/glow.nvim](https://github.com/ellisonleao/glow.nvim).
