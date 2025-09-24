local dap = require 'dap'
local dapui = require 'dapui'
local virtual_text = require 'nvim-dap-virtual-text'

dapui.setup()
virtual_text.setup()

-- PHP Xdebug configuration
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js' },
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    log = false,
    pathMappings = {
      ['/var/www/html'] = vim.fn.getcwd(),
    },
  },
}

-- Node.js debugging configuration
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = function()
      return vim.fn.input 'Process ID: '
    end,
  },
}

dap.configurations.typescript = {
  {
    name = 'ts-node (Node2 with ts-node)',
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = { '-r', 'ts-node/register' },
    runtimeExecutable = 'node',
    args = { '--inspect', '${file}' },
    sourceMaps = true,
    skipFiles = { '<node_internals>/**', 'node_modules/**' },
  },
}

-- Auto open/close DAP UI
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Keymaps for debugging
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
vim.keymap.set('n', '<leader>ds', dap.step_over, { desc = 'Step Over' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Step Out' })
vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Terminate' })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle DAP UI' })
