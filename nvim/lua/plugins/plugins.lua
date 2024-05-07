return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local onedark = require("onedark")
      onedark.setup({
        transparent = true,
      })
      onedark.load()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "html",
          "css",
          "typescript",
          "javascript",
          "tsx",
          "markdown",
          "markdown_inline",
          "lua",
          "svelte",
          "java",
          "go",
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "m4xshen/autoclose.nvim",
    config = function()
      local autoclose = require("autoclose")
      autoclose.setup()
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local ntn = require("nvim-tmux-navigation")
      vim.keymap.set("n", "<C-k>", ntn.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-j>", ntn.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-h>", ntn.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-l>", ntn.NvimTmuxNavigateRight)
    end,
  },
  {
    "yamatsum/nvim-cursorline",
    opts = {
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      },
      cursorline = {
        enable = false,
      },
    },
  },
  {
    "sbdchd/neoformat",
    config = function()
      vim.g.neoformat_try_node_exe = 1
    end,
    keys = {
      { "<Leader>fm", ":Neoformat<CR>" },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {
      columns = { "" },
      keymaps = {
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<Esc>"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 5,
      },
    },
    keys = {
      { "<Leader>o", ":lua require('oil').open_float()<CR>" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      lualine.setup({
        options = {
          theme = "onedark",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },
}
