local status_ok_luasnip, luasnip = pcall(require, "luasnip")
if not status_ok_luasnip then
    return
end

luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})
