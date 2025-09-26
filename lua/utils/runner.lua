-- Enhanced Code Runner for Neovim
-- A modern, extensible code runner using Snacks terminal
-- Supports multiple languages with customizable execution strategies

local M = {}

-- Execution strategies
local EXEC_STRATEGIES = {
  TERMINAL = 'terminal', -- Run in floating terminal
  INLINE = 'inline', -- Execute directly in nvim (for lua)
  BUILD_RUN = 'build_run', -- Compile then run
}

-- Terminal configuration presets
local TERMINAL_CONFIGS = {
  default = {
    win = {
      width = 0.8,
      height = 0.8,
      border = 'single',
      title_pos = 'center',
    },
  },
  large = {
    win = {
      width = 0.9,
      height = 0.9,
      border = 'single',
      title_pos = 'center',
    },
  },
  compact = {
    win = {
      width = 0.6,
      height = 0.6,
      border = 'single',
      title_pos = 'center',
    },
  },
}

-- Helper function to create pause command
local function with_pause(cmd)
  return cmd .. ' && echo "\n--- Execution completed. Press any key to continue ---" && read -n 1'
end

-- Language configurations
-- Each language can specify:
-- - cmd: Command template (% gets replaced with current file)
-- - strategy: How to execute (TERMINAL, INLINE, BUILD_RUN)
-- - config: Terminal configuration preset
-- - env: Environment variables
-- - cwd: Working directory override
local LANGUAGES = {
  -- Interpreted Languages
  javascript = {
    cmd = 'node %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Node.js JavaScript execution',
  },

  typescript = {
    cmd = 'npx ts-node %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'TypeScript execution via ts-node',
  },

  python = {
    cmd = 'python3 %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Python 3 execution',
  },

  php = {
    cmd = 'php %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'PHP execution',
  },

  ruby = {
    cmd = 'ruby %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Ruby execution',
  },

  perl = {
    cmd = 'perl %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Perl execution',
  },

  lua = {
    cmd = 'luafile %',
    strategy = EXEC_STRATEGIES.INLINE,
    description = 'Lua execution within nvim',
  },

  -- Shell Scripts
  sh = {
    cmd = 'sh %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Shell script execution',
  },

  bash = {
    cmd = 'bash %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Bash script execution',
  },

  zsh = {
    cmd = 'zsh %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Zsh script execution',
  },

  fish = {
    cmd = 'fish %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Fish shell script execution',
  },

  -- Compiled Languages (simple compilation)
  go = {
    cmd = 'go run %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Go execution',
  },

  rust = {
    cmd = 'cargo run',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Rust execution via Cargo',
  },

  -- Compiled Languages (build + run)
  c = {
    cmd = 'gcc % -o /tmp/c_out && /tmp/c_out',
    strategy = EXEC_STRATEGIES.BUILD_RUN,
    config = 'default',
    description = 'C compilation and execution',
  },

  cpp = {
    cmd = 'g++ -std=c++17 % -o /tmp/cpp_out && /tmp/cpp_out',
    strategy = EXEC_STRATEGIES.BUILD_RUN,
    config = 'default',
    description = 'C++ compilation and execution',
  },

  -- JVM Languages
  java = {
    cmd = 'javac % && java %:t:r',
    strategy = EXEC_STRATEGIES.BUILD_RUN,
    config = 'default',
    description = 'Java compilation and execution',
  },

  kotlin = {
    cmd = 'kotlinc % -include-runtime -d %:t:r.jar && java -jar %:t:r.jar',
    strategy = EXEC_STRATEGIES.BUILD_RUN,
    config = 'large',
    description = 'Kotlin compilation and execution',
  },

  scala = {
    cmd = 'scala %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Scala execution',
  },

  -- .NET Languages
  cs = {
    cmd = 'dotnet run',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'C# execution via dotnet',
  },

  fsharp = {
    cmd = 'dotnet run',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'F# execution via dotnet',
  },

  -- Functional Languages
  haskell = {
    cmd = 'runhaskell %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Haskell execution',
  },

  elixir = {
    cmd = 'elixir %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Elixir execution',
  },

  erlang = {
    cmd = 'escript %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Erlang execution',
  },

  -- Other Languages
  dart = {
    cmd = 'dart %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Dart execution',
  },

  swift = {
    cmd = 'swift %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Swift execution',
  },

  r = {
    cmd = 'Rscript %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'R script execution',
  },

  julia = {
    cmd = 'julia %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Julia execution',
  },

  nim = {
    cmd = 'nim compile --run %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Nim compilation and execution',
  },

  zig = {
    cmd = 'zig run %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'default',
    description = 'Zig execution',
  },

  -- Assembly
  asm = {
    cmd = 'nasm -f elf64 % -o /tmp/asm_out.o && ld /tmp/asm_out.o -o /tmp/asm_out && /tmp/asm_out',
    strategy = EXEC_STRATEGIES.BUILD_RUN,
    config = 'default',
    description = 'Assembly (NASM) compilation and execution',
  },

  -- Markup/Config (for testing/validation)
  json = {
    cmd = 'jq . %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'compact',
    description = 'JSON validation and pretty-print',
  },

  yaml = {
    cmd = 'yamllint %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'compact',
    description = 'YAML validation',
  },

  xml = {
    cmd = 'xmllint --format %',
    strategy = EXEC_STRATEGIES.TERMINAL,
    config = 'compact',
    description = 'XML validation and formatting',
  },
}

-- Get language configuration
local function get_language_config(filetype)
  return LANGUAGES[filetype]
end

-- Get all supported languages
function M.get_supported_languages()
  local langs = {}
  for ft, config in pairs(LANGUAGES) do
    table.insert(langs, {
      filetype = ft,
      description = config.description,
      strategy = config.strategy,
    })
  end
  table.sort(langs, function(a, b)
    return a.filetype < b.filetype
  end)
  return langs
end

-- Execute command based on strategy
local function execute_command(cmd, config, strategy, title)
  if strategy == EXEC_STRATEGIES.INLINE then
    -- Execute directly in nvim (for lua)
    vim.cmd 'silent! clear'
    vim.cmd(cmd)
    return
  end

  -- For terminal execution, add pause unless it's already there
  local final_cmd = cmd
  if not cmd:match 'read %-n 1' then
    final_cmd = with_pause(cmd)
  end

  -- Get terminal configuration
  local terminal_config = TERMINAL_CONFIGS[config or 'default'] or TERMINAL_CONFIGS.default

  -- Set window title
  terminal_config.win.title = title or (' Running: ' .. vim.fn.expand '%:t' .. ' ')

  -- Execute in terminal
  require('snacks').terminal(final_cmd, terminal_config)
end

-- Main run function
function M.run_code()
  -- Save file before running
  vim.cmd 'w'

  local filetype = vim.bo.filetype
  local lang_config = get_language_config(filetype)

  if not lang_config then
    vim.notify('FileType "' .. filetype .. '" is not supported', vim.log.levels.WARN)
    vim.notify('Use <leader>xl to see all supported languages', vim.log.levels.INFO)
    return
  end

  local expanded_cmd = vim.fn.expandcmd(lang_config.cmd)
  local title = ' Running ' .. filetype .. ': ' .. vim.fn.expand '%:t' .. ' '

  execute_command(expanded_cmd, lang_config.config, lang_config.strategy, title)
end

-- Run with custom command
function M.run_code_with_input()
  -- Save file before running
  vim.cmd 'w'

  local filetype = vim.bo.filetype
  local lang_config = get_language_config(filetype)

  if not lang_config then
    vim.notify('FileType "' .. filetype .. '" is not supported', vim.log.levels.WARN)
    return
  end

  -- Allow custom input for the command
  vim.ui.input({
    prompt = 'Command (' .. filetype .. '): ',
    default = vim.fn.expandcmd(lang_config.cmd),
    completion = 'shellcmd',
  }, function(input)
    if input and input ~= '' then
      local title = ' Custom Run: ' .. vim.fn.expand '%:t' .. ' '
      local terminal_config = TERMINAL_CONFIGS.large
      terminal_config.win.title = title

      local final_cmd = with_pause(input)
      require('snacks').terminal(final_cmd, terminal_config)
    end
  end)
end

-- Show supported languages
function M.list_supported_languages()
  local langs = M.get_supported_languages()
  local lines = { 'Supported Languages:', '' }

  for _, lang in ipairs(langs) do
    local strategy_icon = lang.strategy == EXEC_STRATEGIES.INLINE and '󱖫' or lang.strategy == EXEC_STRATEGIES.BUILD_RUN and '' or ''
    table.insert(lines, string.format('  %s %-12s %s', strategy_icon, lang.filetype, lang.description))
  end

  table.insert(lines, '')
  table.insert(lines, 'Icons: 󱖫 = inline execution,  = build+run,  = terminal execution')

  -- Create a scratch buffer to display the information
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'text')
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  -- Open in a floating window
  local width = 80
  local height = math.min(#lines + 2, 30)
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    style = 'minimal',
    border = 'rounded',
    title = ' Code Runner - Supported Languages ',
    title_pos = 'center',
  }

  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Set up keymaps to close the window
  local close_win = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.keymap.set('n', 'q', close_win, { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', close_win, { buffer = buf, silent = true })
end

-- Add a new language configuration
function M.add_language(filetype, config)
  LANGUAGES[filetype] = config
  vim.notify('Added support for ' .. filetype, vim.log.levels.INFO)
end

-- Keybindings
vim.keymap.set('n', '<leader>x', M.run_code, { desc = 'Run Code' })
vim.keymap.set('n', '<leader>X', M.run_code_with_input, { desc = 'Run Code (Custom)' })
vim.keymap.set('n', '<leader>xl', M.list_supported_languages, { desc = 'List Supported Languages' })

return M
