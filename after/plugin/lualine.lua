-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local leftSeparator = ""
local rightSeparator = ""

local colors = vim.api.nvim_get_hl_by_name("Normal", true)
local bg = string.format("#%06x", colors.background) -- convert decimal number to 6 digit hexadecimal color code

local transparent = { bg = bg }

local empty = require("lualine.component"):extend()

function empty:draw(default_highlight)
  self.status = ""
  self.applied_separator = ""
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = transparent })
    end

    for id, comp in ipairs(section) do
      if type(comp) ~= "table" then
        comp = { comp }
        section[id] = comp
      end

      local left = name:sub(9, 10) < "x"

      comp.separator = left and { right = rightSeparator } or { left = leftSeparator }
    end
  end

  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end

  local last_search = vim.fn.getreg("/")

  if not last_search or last_search == "" then
    return ""
  end

  local searchcount = vim.fn.searchcount({ maxcount = 9999 })

  return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

lualine.setup({
  options = {
    theme = "auto",
    section_separators = {
      left = leftSeparator,
      right = rightSeparator,
    },
  },
  sections = process_sections({
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "filename",
        file_status = true,
      },
      {
        "diagnostics",
        sections = { "error" },
      },
      {
        "diagnostics",
        sections = { "warn" },
      },
      {
        "diagnostics",
        sections = { "hint" },
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { search_result, "filetype" },
    lualine_z = { "%l:%c" },
  }),
})
