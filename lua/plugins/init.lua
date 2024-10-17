return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require("configs.conform")
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
    "JuanZoran/Trans.nvim",
    build = function()
      require("Trans").install()
    end,
    keys = {
      -- 可以换成其他你想映射的键
      { "mm", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "Trans 󰊿 Translate" },
      { "mk", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = "Trans  Auto Play" },
      -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
      { "mi", "<Cmd>TranslateInput<CR>", desc = "Trans 󰔮 Translate From Input" },
    },
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      -- your configuration there
      frontend = {
        default = {
          title = vim.fn.has("nvim-0.9") == 1 and {
            { "", "TransTitleRound" },
            { "󰊿 Trans", "TransTitle" },
            { "", "TransTitleRound" },
          } or nil,
        },
        ---@class TransFrontendOpts
        ---@field keymaps table<string, string>
        hover = {
          ---@type integer Max Width of Hover Window
          width = 45,
          ---@type integer Max Height of Hover Window
          height = 30,

          keymaps = {
            pageup = "[[",
            pagedown = "]]",
            pin = "<leader>[",
            close = "<leader>]",
            -- play         = '_', -- Deprecated
          },
          icon = {
            -- or use emoji
            star = " ", -- ⭐ | ✴ | ✳ | ✲ | ✱ | ✰ | ★ | ☆ | 🌟 | 🌠 | 🌙 | 🌛 | 🌜 | 🌟 | 🌠 | 🌌 | 🌙 |
            notfound = "❔ ", --❔ | ❓ | ❗ | ❕|
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
    "echasnovski/mini.animate",
    recommended = true,
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
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
        },
      })
    end,
  },

  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    config = function()
      require("hop").setup({})
    end,
  },

  {
    "romgrk/barbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      {
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        config = function()
          require("nvim-web-devicons").setup({
            override_by_filename = {
              ["toml"] = {
                icon = "󰬛",
                color = "#753219",
                cterm_color = "88",
                name = "Toml",
              },
            },
          })
        end,
      },
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      highlight_visible = true,
      exclude_name = {'spectre'},
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
    "ldelossa/litee-calltree.nvim",
    event = "LspAttach",
    dependencies = {
      {
        "ldelossa/litee.nvim",
        config = function()
          require("litee.lib").setup({
            panel = {
              orientation = "left",
              panel_size = 30,
            },
          })
        end,
      },
    },
    config = function()
      require("litee.calltree").setup({
        -- hide_cursor = false,
        resolve_symbols = false,
        map_resize_keys = false,
      })
    end,
  },

  {
    "fei6409/log-highlight.nvim",
    ft = "log",
    config = function()
      require("log-highlight").setup({})
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            -- foldfunc = "builtin",
            -- setopt = true,
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    config = function()
      -- Fold options
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup()
    end,
  },

  {
    "cappyzawa/trim.nvim",
    event = "BufRead",
    config = function()
      require("trim").setup({
        -- if you want to ignore markdown file.
        -- you can specify filetypes.
        ft_blocklist = {
          "",
          "aerial",
          "alpha",
          "checkhealth",
          "cmp_menu",
          "diff",
          "lazy",
          "lspinfo",
          "man",
          "markdown",
          "mason",
          "nvcheatsheet",
          "nvdash",
          "TelescopePrompt",
          "TelescopeResults",
          "toggleterm",
          "Trouble",
          "WhichKey",
          "VoltWindow",
          "noice",
          "notify",
        },

        -- if you want to remove multiple blank lines
        patterns = {
          [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
        },

        -- if you want to disable trim on write by default
        trim_on_write = false,

        -- highlight trailing spaces
        highlight = true,
        highlight_bg = "#E62E4D",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      require("nvim-treesitter.install").prefer_git = true
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local conf = require("nvchad.configs.nvimtree")
      conf.renderer.icons.glyphs.folder.default = "󰉋"
      conf.view = {
        adaptive_size = true,
        side = "left",
        width = 30,
        preserve_window_proportions = true,
      }
      return conf
    end,
  },

  {
    "hedyhli/outline.nvim",
    event = "VeryLazy",
    config = function()
      require("outline").setup({
        -- Your setup opts here (leave empty to use defaults)
      })
    end,
  },

  {
    "dwrdx/mywords.nvim",
    event = "VeryLazy",
  },

  {
    "windwp/nvim-spectre",
    lazy = true,
    cmd = { "Spectre" },
    config = function()
      require("spectre").setup()
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function ()
      require("rainbow-delimiters.setup").setup({
        highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
        'RainbowDelimiterRed',
    },
      })
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          local b = require("null-ls").builtins
          require("null-ls").setup({
            sources = {
              -- lua
              b.formatting.stylua,

              -- c/cpp
              b.formatting.clang_format,

              --xml
              b.formatting.xmlformat,

              -- python
              b.formatting.pyink,

              -- json
              b.formatting.jq,
            },

            on_attach = function(client, bufnr)
              -- 检查文件类型，禁用 null-ls 对 C 和 C++ 文件的支持
              if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
                client.stop() -- 停止 LSP 客户端
                return
              end
            end,
          })
        end,
      },
    },
    config = function()
      require("configs.lspconfig")
    end,
  },
}
