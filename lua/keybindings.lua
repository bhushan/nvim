local wk = require("which-key")

vim.g.mapleader = ","

local normalModeMappings = {
    ["<leader>"] = {
        name = "Leader",
        q = { "<cmd>q<cr>", "Quit" },
        Q = { "<cmd>q!<cr>", "Force Quit" },
        w = { "<cmd>w<cr>", "Write" },
        f = { "<cmd>Neoformat<cr>", "Apply formatting on current buffer" },
        t = {
            name = "Telescope",
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            n = {
                "<cmd>Telescope open_nvim_files<cr>",
                "Open Nvim Config Files",
            },
            d = { "<cmd>Telescope open_dotfiles<cr>", "Open Dotfiles" },
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
            h = { "<cmd>SignifyHunkDiff<cr>", "Show git hunk diff" },
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
                "<cmd>lua vim.lsp.buf.delaration()<CR>",
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
    },
    ["<c-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Focus Left Pane" },
    ["<c-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Focus Right Pane" },
    ["<c-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Focus Down Pane" },
    ["<c-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Focus Up Pane" },
    ["1"] = {
        "<cmd>NvimTreeFindFileToggle<cr>",
        "Toggle Project Explorer and open currently opened file",
    },
    ["<space>"] = { "<cmd>nohlsearch<cr>", "Remove highlighting" },
    ["<c-p>"] = { "<cmd>Telescope find_files<cr>", "Find Files" },
    ["<c-r>"] = {
        "<cmd>Telescope lsp_document_symbols<cr>",
        "File Structure",
    },
}

wk.register(normalModeMappings, { mode = "n" })

local insertModeMappings = {
    ["jj"] = { "<ESC>", "Escape" },
}

wk.register(insertModeMappings, { mode = "i" })

local visualModeMappings = {
    ["<"] = { "<gv", "Left Indent Code" },
    [">"] = { ">gv", "Right Indent Code" },
}

wk.register(visualModeMappings, { mode = "v" })
