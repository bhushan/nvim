local cmp = require("cmp")

local lsp_symbols = {
    Text = "   (Text) ",
    Method = "   (Method)",
    Function = "   (Function)",
    Constructor = "   (Constructor)",
    Field = " ﴲ  (Field)",
    Variable = " [] (Variable)",
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
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    formatting = {
        format = function(entry, item)
            item.kind = lsp_symbols[item.kind]

            return item
        end,
    },
    sources = cmp.config.sources({
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
