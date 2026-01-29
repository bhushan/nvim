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
  -- {
  --   'bhushan/laravel.nvim',
  --   enabled = true,
  --   ft = { 'php', 'blade' },
  --   config = function()
  --     require('laravel').setup()
  --   end,
  -- },

  --- Advanced PHP refactoring toolkit with PHPStorm-like capabilities
  --- Provides comprehensive code transformation and restructuring operations
  ---
  --- Key Features:
  --- - Extract Variable/Method/Class/Interface operations
  --- - Introduce Constant/Field/Parameter transformations
  --- - Change Method Signature with parameter management
  --- - Pull Members Up for inheritance refactoring
  --- - Rename Variable/Method/Class with scope awareness
  --- - Context-aware parsing using TreeSitter and regex fallback
  --- - Floating UI dialogs for interactive refactoring
  --- - Automatic code formatting after refactoring operations
  ---
  --- Keymaps:
  --- - <C-e> : Open refactoring menu (PHP files only)
  ---
  --- Usage examples:
  --- - Extract variable: Select expression and choose "Extract Variable"
  --- - Extract method: Select code block and choose "Extract Method"
  --- - Rename class: Place cursor on class name and choose "Rename Class"
  --- - Change signature: Place cursor on method and choose "Change Signature"
  ---
  --- Dependencies: TreeSitter PHP parser (optional but recommended)
  --- @see https://github.com/adibhanna/phprefactoring.nvim
  {
    'adibhanna/phprefactoring.nvim',
    branch = 'main',
    enabled = true,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'php' },
    keys = {
      {
        '<C-e>',
        function()
          -- Define comprehensive refactoring menu options
          local menu_options = {
            { label = 'Extract Variable', action = 'extract_variable' },
            { label = 'Extract Method', action = 'extract_method' },
            { label = 'Extract Class', action = 'extract_class' },
            { label = 'Extract Interface', action = 'extract_interface' },
            { label = 'Introduce Constant', action = 'introduce_constant' },
            { label = 'Introduce Field', action = 'introduce_field' },
            { label = 'Introduce Parameter', action = 'introduce_parameter' },
            { label = 'Change Signature', action = 'change_signature' },
            { label = 'Pull Members Up', action = 'pull_members_up' },
            { label = 'Rename Variable', action = 'rename_variable' },
            { label = 'Rename Method', action = 'rename_method' },
            { label = 'Rename Class', action = 'rename_class' },
          }

          -- Use vim.ui.select with Snacks picker for filtering
          vim.ui.select(menu_options, {
            prompt = 'PHP Refactoring:',
            format_item = function(item)
              return item.label
            end,
          }, function(choice)
            if not choice then
              return
            end

            -- Execute the selected refactoring operation
            local phprefactoring = require 'phprefactoring'
            local action = choice.action

            -- Map menu actions to phprefactoring methods
            if action == 'extract_variable' then
              phprefactoring.extract_variable()
            elseif action == 'extract_method' then
              phprefactoring.extract_method()
            elseif action == 'extract_class' then
              phprefactoring.extract_class()
            elseif action == 'extract_interface' then
              phprefactoring.extract_interface()
            elseif action == 'introduce_constant' then
              phprefactoring.introduce_constant()
            elseif action == 'introduce_field' then
              phprefactoring.introduce_field()
            elseif action == 'introduce_parameter' then
              phprefactoring.introduce_parameter()
            elseif action == 'change_signature' then
              phprefactoring.change_signature()
            elseif action == 'pull_members_up' then
              phprefactoring.pull_members_up()
            elseif action == 'rename_variable' then
              phprefactoring.rename_variable()
            elseif action == 'rename_method' then
              phprefactoring.rename_method()
            elseif action == 'rename_class' then
              phprefactoring.rename_class()
            end
          end)
        end,
        desc = 'Open PHP refactoring menu',
        ft = 'php',
      },
    },
    config = function()
      -- Check if PHP treesitter parser is available
      local has_parser = pcall(vim.treesitter.get_parser, 0, 'php')

      if not has_parser then
        vim.notify('phprefactoring.nvim disabled: Treesitter PHP parser not available', vim.log.levels.WARN)
        return
      end

      -- Initialize phprefactoring with enhanced UI configuration
      require('phprefactoring').setup {
        ui = {
          use_floating_menu = true, -- Enable floating menu interface
          border = 'rounded', -- Aesthetic border style for dialogs
          width = 50, -- Optimal width for refactoring options
        },
        refactor = {
          auto_format = true, -- Automatically format code after refactoring
        },
      }
    end,
  },
}
