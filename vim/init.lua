-- Display numbers
vim.o.number = true

-- New splits below and at the right
vim.o.splitbelow = true
vim.o.splitright = true

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

vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<Leader>ev', ':vsplit $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gx', ':silent execute "!open " . shellescape("<cWORD>")<CR>', { noremap = true })

-- Shifting left/right
vim.api.nvim_set_keymap('v', '<', '<gv', { silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { silent = true })

-- Yank till end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })

-- Keep the cursor in place while joining lines
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', { noremap = true })

-- Open folds when jumping through matches
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

vim.api.nvim_set_keymap('c', '%%', 'expand("%:h")."/"', { noremap = true, expr = true })

-- Add package manager
vim.cmd [[packadd packer.nvim]]

-- Packages
require('packer').startup(function() 
    -- Package manager updates itself
    use 'wbthomason/packer.nvim'

    -- Seamless integration with tmux splits
    use { 'alexghergh/nvim-tmux-navigation', config = function()
        local ntn = require('nvim-tmux-navigation')
        vim.keymap.set('n', "<C-k>", ntn.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<C-j>", ntn.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<C-h>", ntn.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<C-l>", ntn.NvimTmuxNavigateRight)
    end}

    -- Better syntax highlighting
    use 'nvim-treesitter/nvim-treesitter'

    -- Onedark colorscheme
    use { 'navarasu/onedark.nvim', config = function()
        local onedark = require('onedark')
        onedark.setup {
            transparent = true
        }
        onedark.load()
    end}

    use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}
end)
