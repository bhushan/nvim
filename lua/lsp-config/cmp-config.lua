-- Lovingly sourced from TJ DeVries
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/cmp_gh_source.lua
local Job = require("plenary.job")

local source = {}

source.new = function()
    local self = setmetatable({ cache = {} }, { __index = source })

    return self
end

source.complete = function(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()

    -- cache responses
    if not self.cache[bufnr] then
        Job
            :new({
                -- Uses `gh` executable to request the issues from the remote repository.
                "gh",
                "issue",
                "list",
                "--limit",
                "1000",
                "--json",
                "title,number,body",

                on_exit = function(job)
                    local result = job:result()
                    local ok, parsed = pcall(
                        vim.json.decode,
                        table.concat(result, "")
                    )
                    if not ok then
                        vim.notify("Failed to parse gh result")
                        return
                    end

                    local items = {}
                    for _, gh_item in ipairs(parsed) do
                        gh_item.body = string.gsub(gh_item.body or "", "\r", "")

                        table.insert(items, {
                            label = string.format("#%s", gh_item.number),
                            documentation = {
                                kind = "markdown",
                                value = string.format(
                                    "# %s\n\n%s",
                                    gh_item.title,
                                    gh_item.body
                                ),
                            },
                        })
                    end

                    callback({
                        items = items,
                        isIncomplete = false,
                    })
                    self.cache[bufnr] = items
                end,
            })
            :start()
    else
        callback({
            items = self.cache[bufnr],
            isIncomplete = false,
        })
    end
end

source.get_trigger_characters = function()
    return { "#" }
end

source.is_available = function()
    return vim.bo.filetype == "gitcommit"
end

local cmp = require("cmp")

cmp.register_source("gh_issues", source.new())

local lsp_symbols = {
    Text = "   (Text) ",
    Method = "   (Method)",
    Function = "   (Function)",
    Constructor = "   (Constructor)",
    Field = " ﴲ  (Field)",
    Variable = "[] (Variable)",
    Class = "   (Class)",
    Interface = " ﰮ  (Interface)",
    Module = "   (Module)",
    Property = " 襁 (Property)",
    Unit = "   (Unit)",
    Value = "   (Value)",
    Enum = " 練 (Enum)",
    Keyword = "   (Keyword)",
    Snippet = "   (Snippet)",
    Color = "   (Color)",
    File = "   (File)",
    Reference = "   (Reference)",
    Folder = "   (Folder)",
    EnumMember = "   (EnumMember)",
    Constant = " ﲀ  (Constant)",
    Struct = " ﳤ  (Struct)",
    Event = "   (Event)",
    Operator = "   (Operator)",
    TypeParameter = "   (TypeParameter)",
}

cmp.setup({
    formatting = {
        format = function(entry, item)
            item.kind = lsp_symbols[item.kind]

            return item
        end,
    },
    sources = cmp.config.sources({
        { name = "gh_issues", priority = 1050 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "path", priority = 750 },
        { name = "buffer", priority = 500 },
    }),
})

-- Use buffer source while searching anything
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source while in command mode
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
    }),
})
