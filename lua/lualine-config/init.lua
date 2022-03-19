local transparent = {}

local leftSeparator = ""
local rightSeparator = ""

if vim.o.background == "dark" then
    transparent = { bg = "#24292e" }
else
    -- inverting colors for light colorschemes
    transparent = { bg = "#ffffff" }
end

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
        local left = name:sub(9, 10) < "x"
        for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = transparent })
        end
        for id, comp in ipairs(section) do
            if type(comp) ~= "table" then
                comp = { comp }
                section[id] = comp
            end
            comp.separator = left and { right = rightSeparator }
                or { left = leftSeparator }
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
    return last_search
        .. "("
        .. searchcount.current
        .. "/"
        .. searchcount.total
        .. ")"
end

local function modified()
    if vim.bo.modified then
        return "+"
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return "-"
    end
    return ""
end

require("lualine").setup({
    options = {
        theme = "auto",
        section_separators = { left = leftSeparator, right = rightSeparator },
    },
    sections = process_sections({
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            { "filename", file_status = false, path = 3 },
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
        lualine_z = { "%l:%c", "%p%%/%L" },
    }),
    inactive_sections = {
        lualine_c = { "%f %y %m" },
        lualine_x = {},
    },
})
