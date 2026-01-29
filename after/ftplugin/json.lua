-- JSON optimizations
local bo, wo = vim.bo, vim.wo
local bufnr = vim.api.nvim_get_current_buf()

-- Disable regex syntax, use treesitter only
bo.synmaxcol = 300
bo.syntax = ''

-- Large file detection
local function is_large()
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats and stats.size > 1024 * 1024 then
    return true
  end
  return vim.api.nvim_buf_line_count(bufnr) > 5000
end

if is_large() then
  bo.swapfile = false
  wo.foldenable = false
  wo.cursorline = false
  pcall(vim.treesitter.stop, bufnr)
end
