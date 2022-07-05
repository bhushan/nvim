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
        "typescript",
        "json",
        "yaml",
        "markdown",
        "comment",
        "lua",
        "regex",
        "vim",
        "java",
    },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        use_languagetree = true,
        disable = { "NvimTree" },
    },

    indent = {
        enable = true,
    },

    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than n lines, int
    },
})

local opt = vim.opt
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
