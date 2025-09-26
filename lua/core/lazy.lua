-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

--- Lazy.nvim installation path
--- Uses Neovim's standard data directory for plugin manager storage
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

--- Bootstrap lazy.nvim if not installed
--- Automatically clones lazy.nvim from GitHub on first run
--- Uses shallow clone with stable branch for optimal performance
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end

--- Add lazy.nvim to runtime path
--- Prepends lazy.nvim to runtimepath for immediate availability
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
-- Plugin management commands:
--   :Lazy        - Check plugin status and manage plugins
--   :Lazy update - Update all plugins to latest versions
--   Press `?` in Lazy menu for help, `:q` to close

--- Initialize lazy.nvim plugin manager
--- Loads plugins from 'lua/plugins/' directory
--- Configures UI icons based on Nerd Font availability
require('lazy').setup('plugins', {
  ui = {
    --- Icon configuration for plugin manager UI
    --- Uses Nerd Font icons if available, falls back to Unicode symbols
    --- Empty table triggers default Nerd Font icon set when have_nerd_font is true
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
