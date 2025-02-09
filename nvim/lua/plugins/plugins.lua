return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    }, -- if you prefer nvim-web-devicons
    opts = {},
  },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "default" },
    },
    sources = {
      default = { "lsp" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = {
      servers = {
        lua_ls = {},
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      })
    end,
  },
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
  { "echasnovski/mini.pairs", version = false },
  -- {
  --   "m4xshen/autoclose.nvim",
  --   config = function()
  --     local autoclose = require("autoclose")
  --     autoclose.setup()
  --   end,
  -- },
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
    "stevearc/conform.nvim",
    opts = {},
    keys = {
      {
        "<Leader>fm",
        function()
          require("conform").format()
        end,
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier" },
        },
      })
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
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
