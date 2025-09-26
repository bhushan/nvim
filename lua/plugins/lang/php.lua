return {
  -- Laravel IDE PHPstorm plugin like support
  {
    'adibhanna/laravel.nvim',
    enabled = true,
    ft = { 'php', 'blade' },
    dependencies = {
      'folke/snacks.nvim', -- Optional: for enhanced UI
    },
    config = function()
      require('laravel').setup()
    end,
  },

  -- refactoring capabilities
  {
    'adibhanna/phprefactoring.nvim',
    enabled = true,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    ft = 'php',
    config = function()
      require('phprefactoring').setup()
    end,
  },
}
