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
    "romgrk/barbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      highlight_visible = true,
      icons = {
        separator_at_end = false,
        inactive = { separator = { left = "", right = "" } },
        separator = { left = "", right = "" },
        pinned = { button = "", filename = true },
      },
      insert_at_start = false,
      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
        NvimTree = true,
        -- Or, specify the text used for the offset:
        undotree = {
          text = "undotree",
          align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
        },
        -- Or, specify the event which the sidebar executes when leaving:
        ["neo-tree"] = { event = "BufWipeout" },
        -- Or, specify all three
        Outline = { event = "BufWinLeave", text = "", align = "right" },
      },
      -- …etc.
    },

    config = function(_, opts)
      require("barbar").setup(opts)
      vim.cmd([[
        highlight BufferTabpageFill       guibg=#232B3A
        highlight BufferCurrent           guibg=NONE guifg=#A6E3A1
        highlight BufferCurrentERROR      guibg=NONE guifg=#F38BA8
        highlight BufferCurrentWARN       guibg=NONE guifg=#F9E2AF
        highlight BufferCurrentHINT       guibg=NONE guifg=#A6E3A1
        highlight BufferCurrentMod        guibg=NONE guifg=#A6E3A1

        " barbar - inactive buffer
        highlight BufferInactive          guibg=#232B3A
        highlight BufferInactiveADDED     guibg=#232B3A
        highlight BufferInactiveCHANGED   guibg=#232B3A
        highlight BufferInactiveDELETED   guibg=#232B3A
        highlight BufferInactiveERROR     guibg=#232B3A
        highlight BufferInactiveHINT      guibg=#232B3A
        highlight BufferInactiveIcon      guibg=#232B3A
        highlight BufferInactiveIndex     guibg=#232B3A
        highlight BufferInactiveINFO      guibg=#232B3A
        highlight BufferInactiveMod       guibg=#232B3A
        highlight BufferInactiveNumber    guibg=#232B3A
        highlight BufferInactiveSign      guibg=#232B3A
        highlight BufferInactiveSignRight guibg=#232B3A
        highlight BufferInactiveTarget    guibg=#232B3A
        highlight BufferInactiveWARN      guibg=#232B3A

        highlight BufferVisible           guibg=#1C2433
        highlight BufferVisibleADDED      guibg=#1C2433
        highlight BufferVisibleCHANGED    guibg=#1C2433
        highlight BufferVisibleDELETED    guibg=#1C2433
        highlight BufferVisibleERROR      guibg=#1C2433
        highlight BufferVisibleHINT       guibg=#1C2433
        highlight BufferVisibleIcon       guibg=#1C2433
        highlight BufferVisibleIndex      guibg=#1C2433
        highlight BufferVisibleINFO       guibg=#1C2433
        highlight BufferVisibleMod        guibg=#1C2433
        highlight BufferVisibleNumber     guibg=#1C2433
        highlight BufferVisibleSign       guibg=#1C2433
        highlight BufferVisibleSignRight  guibg=#1C2433
        highlight BufferVisibleTarget     guibg=#1C2433
        highlight BufferVisibleWARN       guibg=#1C2433
      ]])
    end,
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
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

  {
    "ojroques/nvim-osc52",
    event = "VeryLazy",
    config = function ()
      require("osc52").setup()
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
