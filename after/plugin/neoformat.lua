local status_ok, _ = pcall(require, "neoformat")
if not status_ok then
    return
end

local g = vim.g

-- Enable alignment
g.neoformat_basic_format_align = true

-- Enable tab to spaces conversion
g.neoformat_basic_format_retab = true

-- Enable trimmming of trailing whitespace
g.neoformat_basic_format_trim = true

-- Run all enabled formatters (by default Neoformat stops after the first formatter succeeds)
g.neoformat_run_all_formatters = false

-- shell formatter
g.shfmt_opt = "-ci"
