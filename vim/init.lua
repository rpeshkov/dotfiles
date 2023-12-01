-- Display numbers
vim.o.number = true

-- vim.o.background = 'light'
--

if vim.g.neovide then
    vim.o.guifont="JetBrainsMono NF:h12"
end

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

vim.keymap.set("n", "<leader><space>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            local onedark = require('onedark')
            onedark.setup {
                transparent = false,
            }
            onedark.load()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup {
                ensure_installed = { "html", "typescript", "javascript", "tsx", "markdown", "markdown_inline", "lua" },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            }
        end
    },
    "ibhagwan/fzf-lua",
    {
        'alexghergh/nvim-tmux-navigation', 
        config = function()
            local ntn = require('nvim-tmux-navigation')
            vim.keymap.set('n', "<C-k>", ntn.NvimTmuxNavigateUp)
            vim.keymap.set('n', "<C-j>", ntn.NvimTmuxNavigateDown)
            vim.keymap.set('n', "<C-h>", ntn.NvimTmuxNavigateLeft)
            vim.keymap.set('n', "<C-l>", ntn.NvimTmuxNavigateRight)
        end
    }
 });

