local wk = require 'which-key'

wk.setup {
  preset = 'modern',
  delay = function(ctx)
    return ctx.plugin and 0 or 200
  end,
  win = {
    border = 'rounded',
    padding = { 1, 2 },
  },
  layout = {
    spacing = 3,
  },
}
