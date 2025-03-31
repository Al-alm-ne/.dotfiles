return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    'stevearc/dressing.nvim',
  },
  config = function()
    local rounded_border_style = {
      top_left = "╭",
      top = "─",
      top_right = "╮",
      left = "│",
      right = "│",
      bottom_left = "╰",
      bottom = "─",
      bottom_right = "╯",
    }
		require("noice").setup({
      cmdline = {
        enabled = true,         -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {},              -- global options for the cmdline. See section on views
        format = {
          cmdline = { pattern = "^:", icon = " 𝝺 ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " 🤔 ⮮", lang = "regex", title = " Search " },
          search_up = { kind = "search", pattern = "^%?", icon = " 🤔 ⮭", lang = "regex", title = " Search " },
          filter = { pattern = "^:%s*!", icon = "  ", lang = "bash", title = " Shell " },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "  ", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = " 🕮  ", title = " Help " },
          input = {}, -- Used by input()
        },
      },
			notify = {
        enabled = false,
        view = "notify",
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
				override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil,     -- when nil, use defaults from documentation
          opts = {},      -- merged with defaults from documentation
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50,  -- Debounce lsp signature help request by 50ms
          },
          view = nil,       -- when nil, use defaults from documentation
          opts = {},        -- merged with defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
        documentation = {
          view = "hover",
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help,                   -- vim help links
          ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters:)"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },
      health = {
        checker = true, -- Disable if you don't want health checks to run
      },
			views = {
        cmdline_popup = {
          position = {
            row = "10%",
            col = "50%",

          },
          size = {
            width = "50%",
            height = "auto",
          },
          border = {
            -- style = rounded_border_style,
            -- style = "none",
          },
          filter_options = {},
          win_options = {
            winhighlight = { Normal = "TelescopePromptNormal", FloatBorder = "DiagnosticInfo" },
          },
        },
        split = {
          enter = true,
        },
        notify = {
          size = {
            width = 30
          }
        },
        popupmenu = {
          -- relative = "editor",
          position = {
            row = "90%",
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = rounded_border_style,
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "TelescopePromptNormal", FloatBorder = "DiagnosticInfo" },
          },
        },
      }, ---@see section on views
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    })
  end,
}
