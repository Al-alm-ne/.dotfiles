return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
    "nvim-tree/nvim-web-devicons", -- If you want devicons
    "stevearc/resession.nvim"       -- Optional, for persistent history
  },
  config = function()
    local get_hex = require('cokeline.hlgroups').get_hl_attr

    require('cokeline').setup({
      show_if_buffers_are_at_least = 1,

      default_hl = {
        fg = function(buffer)
          return
            buffer.is_focused
            and get_hex('ColorColumn', 'bg')
            or get_hex('Normal', 'fg')
        end,
        bg = function(buffer)
          return
            buffer.is_focused
            and get_hex('Normal', 'fg')
            or get_hex('ColorColumn', 'bg')
        end,
      },

      sidebar = {
        filetype = { "NvimTree", "neo-tree", "SidebarNvim" },
        components = {},
      },

      components = {
        {
          text = function(buffer) return ' ' .. buffer.devicon.icon end,
          fg = function(buffer) return buffer.devicon.color end,
        },
        {
          text = function(buffer) return buffer.unique_prefix end,
          fg = get_hex('Comment', 'fg'),
          italic = true
        },
        {
          text = function(buffer) return buffer.filename .. ' ' end,
          underline = function(buffer)
            return buffer.is_hovered and not buffer.is_focused
          end
        },
        {
          text = '',
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end
        },
        {
          text = ' ',
        }
      },
    })
  end
}
