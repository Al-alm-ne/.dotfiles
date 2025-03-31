return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
    "nvim-tree/nvim-web-devicons", -- If you want devicons
    "stevearc/resession.nvim"       -- Optional, for persistent history
  },
  config = function()
    local get_hex = require('cokeline.hlgroups').get_hl_attr
		local yellow = '#F1FA8C'

    require('cokeline').setup({
      show_if_buffers_are_at_least = 1, -- Mostra a barra apenas se houver pelo menos 1 buffer aberto.

			default_hl = {
				fg = function(buffer)
					return
						buffer.is_focused
						and yellow
							or get_hex('Comment', 'fg')
				end,
				bg = 'NONE',
			},
			sidebar = {
        filetype = { "NvimTree", "neo-tree", "SidebarNvim" },
				components = {
          {
            text = function(buf)
              return '🬗🬥🬢🬤🬶🬢🬶🬢🬗🬥🬢🬤🬶🬢🬗🬥🬢🬤🬶🬢🬗🬥🬢🬤🬶🬢🬗🬥🬢🬤🬥🬶🬢🬗🬥🬢🬤🬶🬢'
            end,
            fg = purple,
            bg = function() return get_hex('NvimTreeNormal', 'bg') end,
            bold = true,
          },
        }
      },
			components = {
				{
					text = function(buffer) return (buffer.index ~= 1) and '⫼' or '' end,
					fg = function() return get_hex('Normal', 'fg') end
				},
				{
					text = function(buffer) return '    ' .. buffer.devicon.icon end,
					fg = function(buffer) return buffer.devicon.color end,
				},
				{
					text = function(buffer) return buffer.filename .. '    ' end,
					bold = function(buffer) return buffer.is_focused end
				},
				{
					text = function(buffer)
            if buffer.is_modified then
              return '● '
            else
              return '  '
            end
          end,
          fg = yellow,
        },
        {
          text = '󰖭',
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end,
          fg = get_hex('Error', 'fg'),
        },
        -- Espaço final
        {
          text = ' ',
        },
      },
    })
  end
}
