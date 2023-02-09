require("nvim-tree").setup({
  git = {
    ignore = false,
  },
  view = {
    width = 40,
    side = "right",
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
  },
})

vim.keymap.set("n", "<Leader>1", ":NvimTreeFindFileToggle<CR>")

-- auto command to close nvim tree automatically if its the last buffer
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})
