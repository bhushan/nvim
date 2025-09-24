-- Claude Code Integration for Neovim
-- Enhanced workflow functions for seamless Claude Code integration

local M = {}

-- Get current buffer context for Claude Code
function M.get_current_context()
  local buf = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(buf)
  local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line_count = vim.api.nvim_buf_line_count(buf)

  return {
    filename = filename,
    filetype = filetype,
    cursor_line = cursor_pos[1],
    cursor_col = cursor_pos[2],
    total_lines = line_count,
    relative_path = vim.fn.fnamemodify(filename, ':.')
  }
end

-- Send current file to Claude Code
function M.send_current_file()
  local context = M.get_current_context()
  if context.filename == '' then
    vim.notify('No file to send to Claude Code', vim.log.levels.WARN)
    return
  end

  local Terminal = require('toggleterm.terminal').Terminal
  local claude_term = Terminal:new({
    cmd = 'claude-code "' .. context.relative_path .. '"',
    dir = 'git_dir',
    direction = 'vertical',
    size = vim.o.columns * 0.4,
    close_on_exit = false,
  })
  claude_term:toggle()
end

-- Send selected text to Claude Code
function M.send_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    vim.notify('No selection to send to Claude Code', vim.log.levels.WARN)
    return
  end

  -- Create a temporary file with the selection
  local temp_file = vim.fn.tempname() .. '.' .. vim.bo.filetype
  vim.fn.writefile(lines, temp_file)

  local Terminal = require('toggleterm.terminal').Terminal
  local claude_term = Terminal:new({
    cmd = 'claude-code "' .. temp_file .. '"',
    direction = 'vertical',
    size = vim.o.columns * 0.4,
    close_on_exit = false,
    on_close = function()
      vim.fn.delete(temp_file)
    end,
  })
  claude_term:toggle()
end

-- Quick Claude Code commands
function M.quick_commands()
  local commands = {
    'Explain this code',
    'Optimize this code',
    'Add error handling',
    'Write tests for this',
    'Add documentation',
    'Refactor this code',
    'Find bugs in this code',
    'Convert to TypeScript',
    'Add type hints',
    'Improve performance',
  }

  vim.ui.select(commands, {
    prompt = 'Claude Code Quick Command:',
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      M.send_current_file_with_prompt(choice)
    end
  end)
end

-- Send current file with a custom prompt
function M.send_current_file_with_prompt(prompt)
  local context = M.get_current_context()
  if context.filename == '' then
    vim.notify('No file to send to Claude Code', vim.log.levels.WARN)
    return
  end

  local Terminal = require('toggleterm.terminal').Terminal
  local claude_term = Terminal:new({
    cmd = 'claude-code --prompt "' .. prompt .. '" "' .. context.relative_path .. '"',
    dir = 'git_dir',
    direction = 'vertical',
    size = vim.o.columns * 0.4,
    close_on_exit = false,
  })
  claude_term:toggle()
end

-- Send project context to Claude Code
function M.send_project_context()
  local cwd = vim.fn.getcwd()
  local Terminal = require('toggleterm.terminal').Terminal
  local claude_term = Terminal:new({
    cmd = 'claude-code --context',
    dir = cwd,
    direction = 'vertical',
    size = vim.o.columns * 0.4,
    close_on_exit = false,
  })
  claude_term:toggle()
end

-- Ask Claude Code about error under cursor
function M.explain_error()
  local line = vim.api.nvim_get_current_line()
  local diagnostics = vim.diagnostic.get(0, {lnum = vim.fn.line('.') - 1})

  if #diagnostics == 0 then
    vim.notify('No diagnostic found under cursor', vim.log.levels.INFO)
    return
  end

  local error_msg = diagnostics[1].message
  local prompt = 'Explain this error and suggest a fix: ' .. error_msg .. ' in line: ' .. line

  local Terminal = require('toggleterm.terminal').Terminal
  local claude_term = Terminal:new({
    cmd = 'claude-code --prompt "' .. prompt .. '"',
    direction = 'float',
    float_opts = {
      border = 'rounded',
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.6),
    },
  })
  claude_term:toggle()
end

-- Toggle Claude Code side panel with smart sizing
function M.toggle_claude_panel()
  local Terminal = require('toggleterm.terminal').Terminal
  local claude_term = Terminal:new({
    cmd = 'claude-code',
    dir = 'git_dir',
    direction = 'vertical',
    size = function()
      -- Smart sizing based on screen width
      local width = vim.o.columns
      if width > 200 then
        return math.floor(width * 0.4)
      elseif width > 120 then
        return math.floor(width * 0.45)
      else
        return math.floor(width * 0.5)
      end
    end,
    close_on_exit = false,
    on_open = function(term)
      vim.cmd('startinsert!')
      -- Set up buffer-local keymaps for better integration
      vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    end,
  })
  claude_term:toggle()
end

-- Create a floating Claude Code terminal for quick questions
function M.quick_claude()
  local Terminal = require('toggleterm.terminal').Terminal
  local claude_floating = Terminal:new({
    cmd = 'claude-code',
    direction = 'float',
    float_opts = {
      border = 'rounded',
      width = math.floor(vim.o.columns * 0.9),
      height = math.floor(vim.o.lines * 0.8),
      winblend = 3,
    },
    on_open = function(term)
      vim.cmd('startinsert!')
    end,
  })
  claude_floating:toggle()
end

-- Setup function to register all commands and keybindings
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command('ClaudeFile', M.send_current_file, { desc = 'Send current file to Claude Code' })
  vim.api.nvim_create_user_command('ClaudeSelection', M.send_selection, { desc = 'Send selection to Claude Code', range = true })
  vim.api.nvim_create_user_command('ClaudeQuick', M.quick_commands, { desc = 'Quick Claude Code commands' })
  vim.api.nvim_create_user_command('ClaudeProject', M.send_project_context, { desc = 'Send project context to Claude Code' })
  vim.api.nvim_create_user_command('ClaudeError', M.explain_error, { desc = 'Explain error under cursor' })
  vim.api.nvim_create_user_command('ClaudePanel', M.toggle_claude_panel, { desc = 'Toggle Claude Code side panel' })
  vim.api.nvim_create_user_command('ClaudeFloat', M.quick_claude, { desc = 'Open floating Claude Code' })

  -- Set up keybindings
  vim.keymap.set('n', '<leader>cc', M.toggle_claude_panel, { desc = 'Toggle Claude Code Panel' })
  vim.keymap.set('n', '<leader>cf', M.send_current_file, { desc = 'Send File to Claude' })
  vim.keymap.set('v', '<leader>cs', M.send_selection, { desc = 'Send Selection to Claude' })
  vim.keymap.set('n', '<leader>cq', M.quick_commands, { desc = 'Claude Quick Commands' })
  vim.keymap.set('n', '<leader>cp', M.send_project_context, { desc = 'Send Project to Claude' })
  vim.keymap.set('n', '<leader>ce', M.explain_error, { desc = 'Explain Error with Claude' })
  vim.keymap.set('n', '<leader>cF', M.quick_claude, { desc = 'Quick Claude Float' })

  -- Auto-commands for better integration
  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    callback = function()
      -- Could add auto-notification of errors to Claude if desired
    end,
  })

  -- Integration with LSP for smarter context
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local bufnr = event.buf
      -- Add buffer-local keymaps for LSP + Claude integration
      vim.keymap.set('n', '<leader>ca', function()
        -- Get LSP symbol info and send to Claude
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(bufnr, 'textDocument/hover', params, function(err, result)
          if result and result.contents then
            local content = result.contents.value or result.contents
            M.send_current_file_with_prompt('Explain this symbol: ' .. content)
          end
        end)
      end, { buffer = bufnr, desc = 'Ask Claude about symbol' })
    end,
  })
end

return M