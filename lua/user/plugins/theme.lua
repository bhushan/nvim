require("noirbuddy").setup({
  colors = {
    background = "#ffffff",
    primary = "#EC0034",
    secondary = "#008E0E",
    noir_0 = "#0C3011",
    noir_1 = "#113616",
    noir_2 = "#184B1E",
    noir_3 = "#206428",
    noir_4 = "#34743B",
    noir_5 = "#44834B",
    noir_6 = "#4E8F55",
    noir_7 = "#89B38E",
    noir_8 = "#C8DCCB",
    noir_9 = "#E8F2E9",
    diagnostic_error = "#EC0034",
    diagnostic_warning = "#EEB913",
    diagnostic_info = "#89B38E",
    diagnostic_hint = "#89B38E",
    diff_add = "#008E0E",
    diff_change = "#89B38E",
    diff_delete = "#EC0034",
  },
  styles = {
    italic = true,
    bold = false,
    underline = false,
    undercurl = true,
  },
})

local Color, colors, Group, groups, styles = require("colorbuddy").setup({})

-- remove forground and background from split divider
Group.new("VertSplit", nil, nil)

-- Telescope colors
Group.new("TelescopeNormal", colors.noir_0, colors.noir_9)
Group.new("TelescopeBorder", colors.noir_9, colors.noir_9)
Group.new("TelescopeResultsNormal", colors.noir_5, colors.noir_9)
Group.new("TelescopeMatching", colors.primary)
Group.new("TelescopePromptCounter", colors.noir_7, nil)

-- remove floaterm border
Group.new("FloatermBorder", colors.noir_9, colors.noir_9)
