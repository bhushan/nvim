-- Animations and indent visualization
-- mini.animate: smooth cursor, scroll, window resize
-- mini.indentscope: animated active scope indicator
-- indent-blankline: static indent guides for all levels
return {
  -- Smooth animations for cursor jumps, scroll, and window resize
  {
    'echasnovski/mini.animate',
    event = 'VeryLazy',
    config = function()
      local animate = require 'mini.animate'
      animate.setup {
        cursor = {
          enable = true,
          timing = animate.gen_timing.linear { duration = 80, unit = 'total' },
        },
        scroll = {
          enable = true,
          timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
        },
        resize = {
          enable = true,
          timing = animate.gen_timing.linear { duration = 80, unit = 'total' },
        },
        open = { enable = false },
        close = { enable = false },
      }
    end,
  },

  -- Animated indent scope line following cursor (teal)
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local colors = require('core.colors').arctic
      require('mini.indentscope').setup {
        symbol = '│',
        options = {
          try_as_border = true,
        },
        draw = {
          delay = 50,
          animation = require('mini.indentscope').gen_animation.linear { duration = 60, unit = 'total' },
        },
      }

      -- Disable for certain filetypes
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'dashboard', 'lazy', 'mason', 'trouble', 'snacks_picker', 'snacks_dashboard' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      -- Set scope color to Arctic teal
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = colors.teal })
        end,
      })
      -- Apply immediately
      vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = colors.teal })
    end,
  },

  -- Static indent guides for all levels
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        enabled = false, -- mini.indentscope handles active scope
      },
      exclude = {
        filetypes = { 'help', 'dashboard', 'lazy', 'mason', 'trouble', 'snacks_picker', 'snacks_dashboard' },
      },
    },
  },
}
