-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

vim.g.mapleader = ","

local normalModeMappings = {
  ["<leader>"] = {
    name = "Leader",
    i = { "<cmd>Twilight<cr>", "Toggle focus mode" },
    f = { "<cmd>Neoformat<cr>", "Apply formatting on current buffer" },
    ["1"] = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Telescope file browser" },
    m = { "<cmd>Telescope project<CR>", "Open Projects" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    t = {
      name = "Telescope",
      r = { "<cmd>Telescope oldfiles<cr>", "Open previously opened files" },
      g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    },
    p = {
      name = "Packer",
      r = { "<cmd>PackerClean<cr>", "Remove Unused Plugins" },
      c = { "<cmd>PackerCompile profile=true<cr>", "Recompile Plugins" },
      i = { "<cmd>PackerInstall<cr>", "Install Plugins" },
      p = { "<cmd>PackerProfile<cr>", "Packer Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync Plugins" },
      S = { "<cmd>PackerStatus<cr>", "Packer Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update Plugins" },
    },
    g = {
      name = "Git",
      l = { "<cmd>LazyGit<cr>", "Open Lazygit" },
      p = { "<cmd>Gitsigns preview_hunk<cr>", "Show git hunk diff" },
      k = { "<cmd>Gitsigns prev_hunk<cr>", "Goto previous hunk" },
      j = { "<cmd>Gitsigns next_hunk<cr>", "Goto next hunk" },
      b = { "<cmd>Gitsigns blame_line<cr>", "Git blame" },
      r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset current hunk" },
    },
    l = {
      name = "Language server protocol",
      i = { "<cmd>LspInfo<cr>", "Connected Language Servers" },
      k = {
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        "Signature help",
      },
      K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
      w = {
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        "Add workspace folder",
      },
      W = {
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        "Remove workspace folder",
      },
      l = {
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        "List workspace folder",
      },
      t = {
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        "Type definition",
      },
      d = {
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        "Go to definition",
      },
      D = {
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        "Go to declaration",
      },
      r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
      R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
      e = {
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        "Show line diagnostics",
      },
      n = {
        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        "Go to next diagnostic",
      },
      N = {
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
        "Go to previous diagnostic",
      },
      I = { "<cmd>LspInstallInfo<cr>", "Install language server" },
    },
    d = {
      name = "Debug Adapter Protocol",
      b = {
        "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        "Breakpoint",
      },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
      O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
      l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
      u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
    },
    x = { "<cmd>Run<cr>", "Run current file" },
  },

  ["<a-Up>"] = { ":resize -2<CR>", "Resize UP" },
  ["<a-Down>"] = { ":resize +2<CR>", "Resize Down" },
  ["<a-Left>"] = { ":vertical resize +2<CR>", "Resize Left" },
  ["<a-Right>"] = { ":vertical resize -2<CR>", "Resize Right" },

  K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" }, -- override default K kemap to find in man pages
  ["<space>"] = { "<cmd>nohlsearch<cr>", "Remove highlighting" },
  ["<c-p>"] = { "<cmd>Telescope git_files<cr>", "Git Files" },
  ["<c-p><c-p>"] = { "<cmd>Telescope find_files<cr>", "All Files" },
  ["<c-r>"] = {
    "<cmd>Telescope lsp_document_symbols<cr>",
    "File Structure",
  },
  ["<c-\\>"] = { "<cmd>vsp<cr>", "Vertical Split Window" },
  ["<c-t>"] = { "<cmd>TestNearest<cr>", "Test Nearest" },
  ["<c-s-t>"] = { "<cmd>TestLast<cr>", "Test Last" },
}

wk.register(normalModeMappings, {
  mode = "n",
})

local insertModeMappings = {
  ["jj"] = { "<ESC>", "Escape" },
}

wk.register(insertModeMappings, {
  mode = "i",
})

local visualModeMappings = {
  ["<"] = { "<gv", "Left Indent Code" },
  [">"] = { ">gv", "Right Indent Code" },
}

wk.register(visualModeMappings, {
  mode = "v",
})
