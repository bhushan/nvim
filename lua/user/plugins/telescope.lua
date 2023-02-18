local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

vim.cmd([[
  highlight link TelescopePromptTitle PMenuSel
  highlight link TelescopePreviewTitle PMenuSel
  highlight link TelescopePromptNormal NormalFloat
  highlight link TelescopePromptBorder FloatBorder
  highlight link TelescopeNormal CursorLine
  highlight link TelescopeBorder CursorLineBg
]])

require("telescope").setup({
  defaults = {
    -- prompt_prefix = " 🔍 ",
    prompt_prefix = "   ",
    path_display = { truncate = 1 },
    selection_caret = " » ",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-j>"] = actions.move_selection_next,
      },
    },
  },
  pickers = {
    find_files = {
      prompt_title = "Git Files",
      find_command = { "rg", "--files" },
      previewer = false,
    },
    oldfiles = {
      prompt_title = "History",
    },
    lsp_references = {
      previewer = false,
    },
  },
})

-- Custom finders
builtin.find_all_files = function()
  builtin.find_files({
    prompt_title = "All Files",
    find_command = { "rg", "--files", "--no-ignore", "--hidden" },
    previewer = false,
  })
end

-- safely load extentions if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "live_grep_args")
pcall(require("telescope").load_extension, "project")
pcall(require("telescope").load_extension, "file_browser")

vim.keymap.set("n", "<leader>f", [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set("n", "<leader>F", [[<cmd>lua require('telescope.builtin').find_all_files()<CR>]]) -- custom finder
vim.keymap.set("n", "<leader>b", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set("n", "<leader>g", [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
