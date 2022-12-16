-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    return
end

-- Use a protected require call (pcall) so we don't error out on first use
local status_ok_luasnip, luasnip = pcall(require, "luasnip")
if not status_ok_luasnip then
    return
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- not sure how to go inside docs yet
        ["<C-d>"] = cmp.mapping.scroll_docs(4), -- not sure how to go inside docs yet

        ["<C-Space>"] = cmp.mapping.complete(), -- not sure if i will use it

        ["<CR>"] = cmp.mapping.confirm({
            select = true, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

        ["<Esc>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    min_length = 1,

    preselect = true,

    formatting = {
        format = function(name, item)
            item.kind = lsp_symbols[item.kind]

            return item
        end,
    },

    sources = cmp.config.sources({
        {
            name = "nvim_lsp",
            priority = 1000,
        },
        {
            name = "nvim_lua",
            priority = 800,
        },
        {
            name = "luasnip",
            priority = 700,
        },
        {
            name = "path",
            priority = 600,
        },
        {
            name = "cmdline",
            priority = 500,
        },
        {
            name = "buffer",
            keyword_length = 3,
            priority = 400,
        },
        {
            name = "look",
            keyword_length = 4,
            priority = 300,
        },
    }),

    experimental = {
        ghost_text = true,
    },
})

-- Use buffer source while searching anything
cmp.setup.cmdline("/", {
    sources = { {
        name = "buffer",
    } },
})

-- Use cmdline & path source while in command mode
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        {
            name = "cmdline",
        },
        {
            name = "path",
        },
    }),
})
