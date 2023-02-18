-- refer this wiki to know how to use path specifiers in vim
-- https://vim.fandom.com/wiki/Get_the_name_of_the_current_file
-- https://github.com/anurag3301/my-linux-setup/blob/main/config/nvim/lua/runner.lua
local run_command_table = {
  ["cpp"] = "g++ -std=c++17  % -o %:r && ./%:r < input.txt",
  ["c"] = "gcc % -o %:r.o && %:r.o",
  ["python"] = "python %",
  ["lua"] = "luafile %",
  ["java"] = "javac % && java %:r",
  ["zsh"] = "zsh %",
  ["sh"] = "sh %",
  ["rust"] = "rustc % && ./%:r",
  ["go"] = "go run %",
  ["javascript"] = "node %",
  ["typescript"] = "ts-node %",
  ["php"] = "php %",
}

local function run_code()
  vim.cmd("w") -- save file

  if vim.bo.filetype == "lua" then
    vim.cmd(run_command_table[vim.bo.filetype]) -- execute luafile
    return
  end

  if run_command_table[vim.bo.filetype] then
    vim.cmd("!" .. run_command_table[vim.bo.filetype]) -- execute file
  else
    print("\nFileType not supported\n")
  end
end

vim.keymap.set("n", ",x", function()
  run_code()
end)
