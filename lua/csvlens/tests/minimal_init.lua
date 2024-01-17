local plenary_dir = os.getenv("PLENARY_DIR") or "/tmp/plenary.nvim"
local is_not_a_directory = vim.fn.isdirectory(plenary_dir) == 0
if is_not_a_directory then
    print("===> Cloning testing dependency Plenary")
    vim.fn.system({ "git", "clone", "https://github.com/nvim-lua/plenary.nvim", plenary_dir })
end

local toggleterm_dir = os.getenv("TOGGLETERM_DIR") or "/tmp/toggleterm.nvim"
is_not_a_directory = vim.fn.isdirectory(toggleterm_dir) == 0

if is_not_a_directory then
    print("===> Cloning testing dependency Toggleterm")
    vim.fn.system({ "git", "clone", "https://github.com/akinsho/toggleterm.nvim", toggleterm_dir })
end

vim.opt.rtp:append(".")
vim.opt.rtp:append(plenary_dir)
vim.opt.rtp:append(toggleterm_dir)

vim.cmd("runtime plugin/plenary.vim")
vim.cmd("runtime plugin/toggleterm.vim")
