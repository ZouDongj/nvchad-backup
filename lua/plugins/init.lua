return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGitCurrentFile", "LazyGitFilterCurrentFile" },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        -- "fade", "slide", "fade_in_slide_out", "static"
        stages = "fade",
        on_open = nil,
        on_close = nil,
        timeout = 2000,
        fps = 60,
        render = "wrapped-compact",
        background_colour = "Normal",
        max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
        max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
        -- minimus_width = 50,
        -- ERROR > WARN > INFO > DEBUG > TRACE
        level = "TRACE",
      })

      vim.notify = notify
    end,
  },

  {
    "folke/noice.nvim",
    lazy = true,
    event = "user fileopened",
    dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        lsp = {
          progress = {
            enabled = false,
          },
        },
        presets = {
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
        messages = {
          enabled = true,
          view = "notify",
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
          view_search = "virtualtext",
        },
        health = {
          checker = false,
        },
      })
    end,
  },

  {
    "JuanZoran/Trans.nvim",
    build = function() require 'Trans'.install() end,
    keys = {
      -- 可以换成其他你想映射的键
      { 'mm', mode = { 'n', 'x' }, '<Cmd>Translate<CR>', desc = '󰊿 Translate' },
      { 'mk', mode = { 'n', 'x' }, '<Cmd>TransPlay<CR>', desc = ' Auto Play' },
      -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
      { 'mi', '<Cmd>TranslateInput<CR>', desc = '󰔮 Translate From Input' },
    },
    dependencies = { 'kkharji/sqlite.lua', },
    opts = {
      -- your configuration there
      frontend = {
        default = {
          title = vim.fn.has 'nvim-0.9' == 1 and {
            { '', 'TransTitleRound' },
            { '󰊿 Trans', 'TransTitle' },
            { '', 'TransTitleRound' },
          } or nil,
        },
        ---@class TransFrontendOpts
        ---@field keymaps table<string, string>
        hover = {
          keymaps = {
            pageup   = '[[',
            pagedown = ']]',
            pin      = '<leader>[',
            close    = '<leader>]',
            -- play         = '_', -- Deprecated
          },
          icon = {
            -- or use emoji
            star     = ' ', -- ⭐ | ✴ | ✳ | ✲ | ✱ | ✰ | ★ | ☆ | 🌟 | 🌠 | 🌙 | 🌛 | 🌜 | 🌟 | 🌠 | 🌌 | 🌙 |
            notfound = ' ', --❔ | ❓ | ❗ | ❕|
          },
        },
      },
    },
    config = function(_, opts)
      require("Trans").setup(opts)
    end,
  },

  {
    "folke/persistence.nvim",
    -- Restore last session of current dir
    lazy = true,
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
        pre_save = nil,
      })
    end,
  },

  {
    "nathom/filetype.nvim",
    lazy = true,
    event = "User FileOpened",
    config = function()
      require("filetype").setup({
        overrides = {
          extensions = {
            h = "cpp",
          },
        }
      })
    end
  },

  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    config = function()
      require("hop").setup({})
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    -- Bracket pair rainbow colorize
    event = "VeryLazy",
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    -- event = "VeryLazy",

    config = function()
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  {
    "hedyhli/outline.nvim",
    event = "VeryLazy",
    config = function()
      require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },

  -- custom config
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
}
