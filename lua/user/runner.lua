-- refer this wiki to know how to use path specifiers in vim
-- https://vim.fandom.com/wiki/Get_the_name_of_the_current_file
-- https://github.com/anurag3301/my-linux-setup/blob/main/config/nvim/lua/runner.lua

local run_command_table = {
  php = { cmd = 'php %', float = true },
  python = { cmd = 'python3 %', float = true },
  lua = { cmd = 'luafile %', float = false },
  zsh = { cmd = 'zsh %', float = true },
  sh = { cmd = 'sh %', float = true },
  javascript = { cmd = 'node %', float = true },
  typescript = { cmd = 'ts-node %', float = true },
}

local function run_code()
  vim.cmd 'w' -- save file

  local language_table = run_command_table[vim.bo.filetype]

  if language_table then
    local expanded_cmd = vim.fn.expandcmd(language_table.cmd)

    if language_table.float then
      vim.cmd 'silent! FloatermKill'
      vim.cmd('FloatermNew! ' .. expanded_cmd)
    else
      vim.cmd 'silent! clear'
      vim.cmd(expanded_cmd)
    end
  else
    print '\nFileType not supported\n'
  end
end

vim.keymap.set('n', '<leader>x', run_code)
