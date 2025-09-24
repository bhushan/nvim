-- Web development file type configurations
vim.filetype.add({
  filename = {
    -- Environment files
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["*.env"] = "sh",
    ["*.envrc"] = "sh",

    -- Laravel/PHP specific files
    ["artisan"] = "php",
    [".php-cs-fixer.php"] = "php",
    ["composer.lock"] = "json",

    -- JavaScript/TypeScript config files
    [".eslintrc"] = "json",
    [".babelrc"] = "json",
    [".prettierrc"] = "json",
    ["tsconfig.json"] = "jsonc",
    ["jsconfig.json"] = "jsonc",

    -- Vue/Nuxt config files
    ["nuxt.config.js"] = "javascript",
    ["nuxt.config.ts"] = "typescript",
    ["vue.config.js"] = "javascript",
    ["vite.config.js"] = "javascript",
    ["vite.config.ts"] = "typescript",
  },

  extension = {
    -- Laravel Blade templates
    ["blade.php"] = "blade",

    -- Vue single file components
    ["vue"] = "vue",

    -- TypeScript React
    ["tsx"] = "typescriptreact",
    ["jsx"] = "javascriptreact",
  }
})
