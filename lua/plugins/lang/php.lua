return {
  -- Laravel IDE PHPstorm plugin like support
  {
    'adibhanna/laravel.nvim',
    enabled = false,
    -- dir = "~/Developer/opensource/laravel.nvim",
    ft = { 'php', 'blade' },
    dependencies = {
      'folke/snacks.nvim', -- Optional: for enhanced UI
    },
    config = function()
      require('laravel').setup {
        notifications = false,
        debug = false,
        keymaps = true,
      }
    end,
  },

  -- refactoring capabilities
  {
    'adibhanna/phprefactoring.nvim',
    enabled = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    ft = 'php',
    config = function()
      require('phprefactoring').setup()
    end,
  },
}
