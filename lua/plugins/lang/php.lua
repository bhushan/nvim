--- PHP Language Support Plugins
--- Provides Laravel-specific features and PHP refactoring capabilities
--- Enhances PHP development workflow with IDE-like functionality
--- @module plugins.lang.php

return {
  --- Laravel development assistant with PHPStorm-like features
  --- Provides artisan commands, route navigation, config completion
  ---
  --- Features:
  --- - Artisan command runner with fuzzy search
  --- - Jump to route definitions and controllers
  --- - Model and migration navigation
  --- - Blade template support
  --- - Config and translation key completion
  ---
  --- Usage examples:
  --- - :Artisan make:controller UserController
  --- - :Laravel routes (list all routes)
  --- - gd on route name to jump to controller action
  --- - Auto-completion for config('app.name') and __('messages.welcome')
  {
    'adibhanna/laravel.nvim',
    enabled = true,
    ft = { 'php', 'blade' },
    dependencies = {
      'folke/snacks.nvim', -- Enhanced UI for command palette
    },
    config = function()
      require('laravel').setup()
    end,
  },

  --- PHP refactoring tools for code transformation
  --- Provides automated refactoring operations for cleaner code
  ---
  --- Refactoring operations:
  --- - Extract method/variable from selection
  --- - Rename class/method/variable with scope awareness
  --- - Convert array to collection/vice versa
  --- - Generate getters/setters/constructors
  --- - Optimize imports and namespace declarations
  --- - Extract interface from class
  ---
  --- Usage examples:
  --- - Visual select code → :PhpExtractMethod → name it
  --- - :PhpRename on variable to rename across scope
  --- - :PhpGenerateGetter on property to create getter
  --- - :PhpOptimizeImports to clean unused imports
  {
    'adibhanna/phprefactoring.nvim',
    enabled = true,
    dependencies = {
      'MunifTanjim/nui.nvim', -- UI components for refactoring dialogs
    },
    ft = 'php',
    config = function()
      require('phprefactoring').setup()
    end,
  },
}
