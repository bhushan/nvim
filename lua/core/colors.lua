--- Catppuccin Mocha color palette
--- Central color definitions for all Neovim plugins
--- Reference: colors/catppuccin-mocha.md
--- @module core.colors

local M = {}

-- Base colors
M.base = '#1e1e2e'
M.mantle = '#181825'
M.crust = '#11111b'
M.surface0 = '#313244'
M.surface1 = '#45475a'
M.surface2 = '#585b70'

-- Text colors
M.text = '#cdd6f4'
M.subtext1 = '#bac2de'
M.subtext0 = '#a6adc8'
M.overlay2 = '#9399b2'
M.overlay1 = '#7f849c'
M.overlay0 = '#6c7086'

-- Syntax colors
M.red = '#f38ba8'
M.maroon = '#eba0ac'
M.peach = '#fab387'
M.yellow = '#f9e2af'
M.green = '#a6e3a1'
M.teal = '#94e2d5'
M.sky = '#89dceb'
M.sapphire = '#74c7ec'
M.blue = '#89b4fa'
M.lavender = '#b4befe'
M.mauve = '#cba6f7'
M.pink = '#f5c2e7'
M.flamingo = '#f2cdcd'
M.rosewater = '#f5e0dc'

-- Arctic Blue accent palette (custom overrides for stream theme)
M.arctic = {
  ice = '#7dcfff',       -- keywords: local, return, function, if, for
  purple = '#bb9af7',    -- functions, method calls
  amber = '#e0af68',     -- strings
  teal = '#73daca',      -- types, classes
  mint = '#9ece6a',      -- built-in functions, require
  rose = '#f7768e',      -- constants, numbers, booleans
  comment = '#7a80a3',   -- comments (brighter than default overlay0)
  cursorline = '#292e42', -- cursor line background
  visual = '#33467c',    -- visual selection
  gutter = '#3b4261',    -- line numbers (active)
}

return M
