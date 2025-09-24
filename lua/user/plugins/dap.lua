local dap = require 'dap'
local dapui = require 'dapui'
local virtual_text = require 'nvim-dap-virtual-text'

dapui.setup()
virtual_text.setup()

-- Node.js debugging configuration
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = { vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
  }
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'pwa-node',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'pwa-node',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}

dap.configurations.typescript = {
  {
    name = 'ts-node (PWA Node with ts-node)',
    type = 'pwa-node',
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
