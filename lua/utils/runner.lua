--- Enhanced Code Runner for Neovim
--- A modern, extensible code runner using Snacks terminal
--- Supports multiple languages with customizable execution strategies
--- @module code_runner

local M = {}

--- Execution strategy types
--- Defines how code should be executed for different languages
local EXEC_STRATEGIES = {
  TERMINAL = 'terminal', --- Run in floating terminal window
  INLINE = 'inline', --- Execute directly within nvim (Lua only)
  BUILD_RUN = 'build_run', --- Compile then run (C, C++, Java, etc.)
}

--- Terminal window configuration presets
--- Different size presets for terminal windows based on use case
local TERMINAL_CONFIGS = {
  --- Default terminal size (80% width/height)
  default = {
    win = {
      width = 0.8,
      height = 0.8,
      border = 'single',
      title_pos = 'center',
    },
  },
  --- Large terminal size (90% width/height)
  large = {
    win = {
      width = 0.9,
      height = 0.9,
      border = 'single',
      title_pos = 'center',
    },
  },
  --- Compact terminal size (60% width/height)
  compact = {
    win = {
      width = 0.6,
      height = 0.6,
      border = 'single',
      title_pos = 'center',
    },
  },
}

--- Append pause prompt to command for user acknowledgment
--- Prevents terminal from closing immediately after execution
--- @param cmd string Command to wrap with pause
--- @return string Command with pause appended
local function with_pause(cmd)
  return cmd .. ' && echo "\n--- Execution completed. Press any key to continue ---" && read -n 1'
end

--- Language execution configurations
--- Maps filetypes to execution commands and strategies
--- @type table<string, {cmd: string, strategy: string, config?: string, description: string}>
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

--- Retrieve language configuration for given filetype
--- @param filetype string The filetype to lookup
--- @return table|nil Language configuration or nil if not supported
local function get_language_config(filetype)
  return LANGUAGES[filetype]
end

--- Get all supported languages with metadata
--- Returns alphabetically sorted list of language configurations
--- @return table[] Array of language configurations with filetype, description, and strategy
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

--- Execute command using appropriate strategy
--- Handles inline, terminal, and build+run execution modes
--- @param cmd string Command to execute
--- @param config string Terminal configuration preset name
--- @param strategy string Execution strategy (TERMINAL, INLINE, BUILD_RUN)
--- @param title string Window title for terminal
local function execute_command(cmd, config, strategy, title)
  if strategy == EXEC_STRATEGIES.INLINE then
    -- Execute directly in nvim (Lua only)
    vim.cmd 'silent! clear'
    vim.cmd(cmd)
    return
  end

  -- Append pause to terminal commands unless already present
  local final_cmd = cmd
  if not cmd:match 'read %-n 1' then
    final_cmd = with_pause(cmd)
  end

  -- Apply terminal configuration
  local terminal_config = TERMINAL_CONFIGS[config or 'default'] or TERMINAL_CONFIGS.default
  terminal_config.win.title = title or (' Running: ' .. vim.fn.expand '%:t' .. ' ')

  -- Execute in Snacks terminal
  require('snacks').terminal(final_cmd, terminal_config)
end

--- Run current buffer using configured language settings
--- Saves file before execution and validates filetype support
function M.run_code()
  -- Auto-save before execution
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

--- Run current buffer with custom command input
--- Prompts user for custom command with filetype default as starting point
function M.run_code_with_input()
  -- Auto-save before execution
  vim.cmd 'w'

  local filetype = vim.bo.filetype
  local lang_config = get_language_config(filetype)

  if not lang_config then
    vim.notify('FileType "' .. filetype .. '" is not supported', vim.log.levels.WARN)
    return
  end

  -- Prompt for custom command with default pre-filled
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

--- Display supported languages in floating window
--- Shows all configured languages with icons indicating execution strategy
function M.list_supported_languages()
  local langs = M.get_supported_languages()
  local lines = { 'Supported Languages:', '' }

  for _, lang in ipairs(langs) do
    local strategy_icon = lang.strategy == EXEC_STRATEGIES.INLINE and '󱖫' or lang.strategy == EXEC_STRATEGIES.BUILD_RUN and '' or ''
    table.insert(lines, string.format('  %s %-12s %s', strategy_icon, lang.filetype, lang.description))
  end

  table.insert(lines, '')
  table.insert(lines, 'Icons: 󱖫 = inline execution,  = build+run,  = terminal execution')

  -- Create scratch buffer for language list
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'text')
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  -- Calculate window dimensions
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

  -- Close window keybindings
  local close_win = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.keymap.set('n', 'q', close_win, { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', close_win, { buffer = buf, silent = true })
end

--- Register new language configuration dynamically
--- Allows runtime addition of language support
--- @param filetype string The filetype identifier
--- @param config table Language configuration (cmd, strategy, config, description)
function M.add_language(filetype, config)
  LANGUAGES[filetype] = config
  vim.notify('Added support for ' .. filetype, vim.log.levels.INFO)
end

--- Run code in current buffer
--- Keybinding: <leader>x
vim.keymap.set('n', '<leader>x', M.run_code, { desc = 'Run Code' })

--- Run code with custom command input
--- Keybinding: <leader>X
vim.keymap.set('n', '<leader>X', M.run_code_with_input, { desc = 'Run Code (Custom)' })

--- Display all supported languages
--- Keybinding: <leader>xl
vim.keymap.set('n', '<leader>xl', M.list_supported_languages, { desc = 'List Supported Languages' })

return M
