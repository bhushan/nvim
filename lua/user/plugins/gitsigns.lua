require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map('v', '<leader>gs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = '[G]it [s]tage hunk' })
    map('v', '<leader>gr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = '[G]it [r]eset hunk' })
    -- normal mode
    map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [s]tage hunk' })
    map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [r]eset hunk' })
    map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer' })
    map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = '[G]it [u]ndo stage hunk' })
    map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
    map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]it [p]review hunk' })
    map('n', '<leader>gb', gitsigns.blame_line, { desc = '[G]it [b]lame line' })
    map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [d]iff against index' })
    map('n', '<leader>gD', function()
      gitsigns.diffthis '@'
    end, { desc = '[G]it [D]iff against last commit' })
    -- Toggles
    map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[G]it [t]oggle [b]lame line' })
    map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = '[G]it [t]oggle [d]eleted' })
  end,
}
