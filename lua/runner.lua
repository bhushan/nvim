-- refer this wiki to know how to use path specifiers in vim
-- https://vim.fandom.com/wiki/Get_the_name_of_the_current_file
-- https://github.com/anurag3301/my-linux-setup/blob/main/config/nvim/lua/runner.lua

local run_command_table = {
    ["cpp"] = "g++ % -o %:r && ./%:r",
    ["c"] = "gcc % -o %:r && ./%:r",
    ["python"] = "python %",
    ["lua"] = "lua %",
    ["java"] = "javac % && java %:r",
    ["zsh"] = "zsh %",
    ["sh"] = "sh %",
    ["rust"] = "rustc % && ./%:r",
    ["go"] = "go run %",
    ["javascript"] = "node %",
}

function Run_code()
    if run_command_table[vim.bo.filetype] then
        vim.cmd("!" .. run_command_table[vim.bo.filetype])
    else
        print("\nFileType not supported\n")
    end
end

vim.cmd("command! Run :lua Run_code()")
