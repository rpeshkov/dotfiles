-- Display numbers
vim.o.number = true

vim.o.termguicolors = true

-- New splits below and at the right
vim.o.splitbelow = true
vim.o.splitright = true

-- Show cursor line
vim.o.cursorline = true

-- Use spaces instead of tabs with 4 spaces indent
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Enable mouse
vim.o.mouse = "a"

-- Use ripgrep as grep program
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.o.clipboard = "unnamedplus"
vim.o.swapfile = false

vim.g.mapleader = " "
