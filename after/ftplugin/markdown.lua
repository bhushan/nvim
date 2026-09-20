-- Markdown buffer-local mappings

--- Toggle the in-editor markdown preview (render-markdown.nvim)
--- Flips between the rendered view and the raw markdown file, in the same window
vim.keymap.set('n', '<leader>mp', '<cmd>RenderMarkdown toggle<cr>', {
  buffer = true,
  desc = '[M]arkdown [p]review toggle (rendered/raw)',
})
