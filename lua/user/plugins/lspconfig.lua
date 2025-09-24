vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>lD', require('telescope.builtin').lsp_type_definitions, '[L]SP Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ld', require('telescope.builtin').lsp_document_symbols, '[L]SP [d]ocument symbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]SP [w]orkspace symbols')

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('<leader>lr', vim.lsp.buf.rename, '[L]SP [r]ename')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>la', vim.lsp.buf.code_action, '[L]SP code [a]ction')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    map('<leader>lf', vim.lsp.buf.format, '[L]SP [f]ormat buffer')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- The following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map('<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
      end, '[L]SP toggle inlay [h]ints')
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- Set position encoding to utf-16 to avoid warning
capabilities.general = capabilities.general or {}
capabilities.general.positionEncodings = { 'utf-16' }

local servers = {
  vtsls = {
    init_options = {
      preferences = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        importModuleSpecifierPreference = 'non-relative',
        includePackageJsonAutoImports = 'auto',
        includeCompletionsForModuleExports = true,
        includeAutomaticOptionalChainCompletions = true,
      },
    },
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        suggest = {
          includeCompletionsForModuleExports = true,
        },
        preferences = {
          importModuleSpecifier = 'non-relative',
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        suggest = {
          includeCompletionsForModuleExports = true,
        },
      },
    },
  },

  eslint = {
    settings = {
      workingDirectory = { mode = 'auto' },
      codeActionOnSave = {
        enable = true,
        mode = 'all',
      },
      format = true,
    },
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'EslintFixAll',
      })
    end,
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },

  intelephense = {
    settings = {
      intelephense = {
        stubs = {
          'bcmath',
          'bz2',
          'calendar',
          'Core',
          'curl',
          'date',
          'dba',
          'dom',
          'enchant',
          'fileinfo',
          'filter',
          'ftp',
          'gd',
          'gettext',
          'hash',
          'iconv',
          'imap',
          'intl',
          'json',
          'ldap',
          'libxml',
          'mbstring',
          'mcrypt',
          'mysql',
          'mysqli',
          'password',
          'pcntl',
          'pcre',
          'PDO',
          'pdo_mysql',
          'Phar',
          'readline',
          'recode',
          'Reflection',
          'regex',
          'session',
          'SimpleXML',
          'soap',
          'sockets',
          'sodium',
          'SPL',
          'standard',
          'superglobals',
          'sysvsem',
          'sysvshm',
          'tokenizer',
          'xml',
          'xdebug',
          'xmlreader',
          'xmlwriter',
          'yaml',
          'zip',
          'zlib',
          -- Laravel stubs
          'laravel',
        },
        files = {
          maxSize = 5000000,
        },
        completion = {
          insertUseDeclaration = true,
          fullyQualifyGlobalConstantsAndFunctions = false,
          suggestObjectOperatorStaticMethods = true,
          maxItems = 100,
        },
        format = {
          enable = true,
        },
        environment = {
          includePaths = { 'vendor/' },
        },
      },
    },
  },
}

-- Ensure the servers and tools above are installed
--  To check the current status of installed tools and/or manually install
--  other tools, you can run
--    :Mason
--
--  You can press `g?` for help in this menu.
require('mason').setup()

-- Configure mason-tool-installer for formatters, linters, and debug adapters
require('mason-tool-installer').setup {
  ensure_installed = {
    'prettierd', -- Formatter for JS/TS/HTML/CSS/JSON/Markdown
    'js-debug-adapter', -- Debug adapter for JavaScript/TypeScript
  },
  auto_update = false,
  run_on_start = true,
}

local ensure_installed = vim.tbl_keys(servers or {})

vim.list_extend(ensure_installed, {
  'lua_ls',
  'jsonls',
  'vtsls',
  'eslint',
  'intelephense',
})

require('mason-lspconfig').setup {
  automatic_installation = true,
  ensure_installed = ensure_installed,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}
