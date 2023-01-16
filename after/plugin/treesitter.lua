-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

treesitter_config.setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        "html",
        "css",
        "scss",
        "javascript",
        "jsdoc",
        "typescript",
        "json",
        "graphql",
        "bash",
        "dockerfile",
        "markdown",
        "java",
        "php",
        "lua",
        "help",
        "vim",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "gitattributes",
    },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- use_languagetree = true,
        disable = { "NvimTree" },
    },

    indent = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },

    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than n lines, int
    },
})

-- vim.wo.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldenable = false
