vim.g.signify_vcs_cmds = { git = "git diff --no-color --no-ext-diff -U0 HEAD -- %f" }
vim.g.signify_sign_add = "│"
vim.g.signify_sign_change = "│"
vim.g.signify_sign_delete = "│"
vim.cmd("highlight SignifySignAdd ctermfg=green guifg=#00ff00 cterm=NONE gui=NONE")
vim.cmd("highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE")
vim.cmd("highlight SignifySignDelete ctermfg=red guifg=#ff0000 cterm=NONE gui=NONE")
