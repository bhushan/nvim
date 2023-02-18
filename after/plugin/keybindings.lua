-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    return
end

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local normalModeMappings = {
    ["<leader>"] = {
        name = "Leader",
        -- i = { "<cmd>Twilight<cr>", "Toggle focus mode" },
        f = { "<cmd>lua vim.lsp.buf.format()<cr><cmd>w<cr>", "Apply formatting on current buffer and save" },
        -- f = { "<cmd>Neoformat<cr><cmd>w<cr>", "Apply formatting on current buffer and save" },
        -- ["1"] = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Telescope file browser" },
        ["1"] = { "<cmd>NvimTreeFindFileToggle<cr>", "Telescope file browser" },
        m = { "<cmd>Telescope project<CR>", "Open Projects" },
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        t = {
            name = "Telescope",
            r = { "<cmd>Telescope oldfiles<cr>", "Open previously opened files" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
        },
        p = {
            name = "Packer",
            -- r = { "<cmd>PackerClean<cr>", "Remove Unused Plugins" },
            c = { "<cmd>PackerCompile profile=true<cr>", "Recompile Plugins" },
            -- i = { "<cmd>PackerInstall<cr>", "Install Plugins" },
            -- p = { "<cmd>PackerProfile<cr>", "Packer Profile" },
            s = { "<cmd>PackerSync<cr>", "Sync Plugins" },
            -- S = { "<cmd>PackerStatus<cr>", "Packer Status" },
            u = { "<cmd>PackerUpdate<cr>", "Update Plugins" },
        },
        g = {
            name = "Git",
            l = { "<cmd>LazyGit<cr>", "Open Lazygit" },
            p = { "<cmd>SignifyHunkDiff<cr>", "Show git hunk diff" },
            r = { "<cmd>SignifyHunkUndo<cr>", "Reset hunk under the cursor" },
        },
        l = {
            name = "Language server protocol",
            i = { "<cmd>LspInfo<cr>", "Connected Language Servers" },
            I = { "<cmd>Mason<cr>", "Install language server" },
            -- k = {
            --     "<cmd>lua vim.lsp.buf.signature_help()<CR>",
            --     "Signature help",
            -- },
            -- K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
            -- w = {
            --     "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
            --     "Add workspace folder",
            -- },
            -- W = {
            --     "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
            --     "Remove workspace folder",
            -- },
            -- l = {
            --     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            --     "List workspace folder",
            -- },
            -- t = {
            --     "<cmd>lua vim.lsp.buf.type_definition()<CR>",
            --     "Type definition",
            -- },
            -- d = {
            --     "<cmd>lua vim.lsp.buf.definition()<CR>",
            --     "Go to definition",
            -- },
            -- D = {
            --     "<cmd>lua vim.lsp.buf.declaration()<CR>",
            --     "Go to declaration",
            -- },
            -- R = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
            -- r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
            -- a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
            -- e = {
            --     "<cmd>lua vim.diagnostic.open_float()<CR>",
            --     "Show line diagnostics",
            -- },
            -- n = {
            --     "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
            --     "Go to next diagnostic",
            -- },
            -- N = {
            --     "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
            --     "Go to previous diagnostic",
            -- },
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
        s = { "<cmd>w<cr>", "Save current file" },
        q = { "<cmd>bdelete<cr>", "Close current file" },
        c = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace currently selected word in file" },
    },

    ["gf"] = { "<cmd>edit <cfile><cr>", "Opens file under cursor even if doesnt exists" },

    ["<a-Up>"] = { ":resize -2<CR>", "Resize UP" },
    ["<a-Down>"] = { ":resize +2<CR>", "Resize Down" },
    ["<a-Left>"] = { ":vertical resize +2<CR>", "Resize Left" },
    ["<a-Right>"] = { ":vertical resize -2<CR>", "Resize Right" },

    J = { "mzJ`z", "Join next lines" }, -- keeps the cursor on current position
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" }, -- override default K kemap to find in man pages

    n = { "nzzzv", "Goto next search but keep position at center" },
    N = { "Nzzzv", "Goto previous search but keep position at center" },

    ["q:"] = { ":q", "Fix annoying command line history thing" },

    ["<space>"] = { "<cmd>nohlsearch<cr>", "Remove highlighting" },
    ["<c-p>"] = { "<cmd>Telescope find_files<cr>", "Git Files" },
    ["<c-p><c-p>"] = { "<cmd>Telescope find_all_files<cr>", "All Files" },
    ["<c-r>"] = {
        "<cmd>Telescope lsp_document_symbols<cr>",
        "File Structure",
    },
    ["<c-\\>"] = { "<cmd>vsp<cr>", "Vertical Split Window" },
    ["<c-t>"] = { "<cmd>TestNearest<cr>", "Test Nearest" },
    ["<c-s-t>"] = { "<cmd>TestLast<cr>", "Test Last" },
    -- ["<c-d>"] = { "<c-d>zz", "Move down" },
    -- ["<c-u>"] = { "<c-u>zz", "Move up" },
}

wk.register(normalModeMappings, {
    mode = "n",
})

local insertModeMappings = {
    ["jj"] = { "<ESC>", "Escape" },
    [";;"] = { "<Esc>A;<Esc>", "Easy insertion of a trailing ;" },
    [",,"] = { "<Esc>A,<Esc>", "Easy insertion of a trailing ," },
}

wk.register(insertModeMappings, {
    mode = "i",
})

local visualModeMappings = {
    ["<"] = { "<gv", "Left Indent Code" },
    [">"] = { ">gv", "Right Indent Code" },
    ["p"] = { '"_dP', "Paste without yanking" },
    ["y"] = { "myy`y", "Maintain the cursor position when yanking a visual selection" },
    ["Y"] = { "myY`y", "Maintain the cursor position when yanking a visual selection" },
}

wk.register(visualModeMappings, {
    mode = "v",
})

local terminalModeMappings = {
    ["<Esc>"] = { "<C-\\><C-n>", "Exit to terminal mode" },
}

wk.register(terminalModeMappings, {
    mode = "t",
})
