--- In-editor markdown previewer
--- Renders headings, code blocks, tables, checkboxes, callouts, and links inline
--- in the buffer using treesitter, no browser or external build step required.
--- Rendered view is shown by default when a markdown file opens; toggle back to
--- the raw file with <leader>mp (see after/ftplugin/markdown.lua).
return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {},
}
