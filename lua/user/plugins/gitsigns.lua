require("gitsigns").setup({
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    map("n", "]h", "&diff ? ']h' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[h", "&diff ? '[h' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
    map("n", "<Leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
    map("n", "<Leader>hS", "<cmd>Gitsigns undo_stage_hunk<CR>")
    map("n", "<Leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
    map("n", "<Leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
    map("n", "<Leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
  end,
})
