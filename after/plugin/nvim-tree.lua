-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

nvim_tree.setup({
    git = {
        ignore = false,
    },
    view = {
        width = 40,
        hide_root_folder = true,
        side = "right",
    },
})

