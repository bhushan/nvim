-- GitHub Dimmed theme (see colors/github-dimmed.md)
return {
  'projekt0n/github-nvim-theme',
  lazy = false,
  priority = 1000,
  config = function()
    require('github-theme').setup {
      options = {
        transparent = false,
        dim_inactive = false,
        styles = {
          comments = 'italic',
          keywords = 'bold',
          functions = 'NONE',
          variables = 'NONE',
        },
      },
    }
    vim.cmd.colorscheme 'github_dark_dimmed'
  end,
}
