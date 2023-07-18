require("nvim-treesitter.configs").setup({
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
    -- "help",
    "vim",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "gitattributes",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    disable = { "NvimTree" },
  },
  indent = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.outer",
      },
    },
  },
})
