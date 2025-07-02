-- Conform.nvim - Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim
--
-- Conform provides a unified interface for formatting files with external formatters.
-- It's faster and more reliable than null-ls and integrates well with LSP.

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>F',
      function()
        require('conform').format({ 
          async = true, 
          lsp_fallback = true,
          range = {
            start = vim.api.nvim_buf_get_mark(0, '<'),
            ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
          }
        })
      end,
      mode = 'v',
      desc = '[F]ormat selection',
    },
  },
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      vue = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      scss = { { 'prettierd', 'prettier' } },
      less = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      jsonc = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
      markdown = { { 'prettierd', 'prettier' } },
      graphql = { { 'prettierd', 'prettier' } },
      handlebars = { { 'prettierd', 'prettier' } },
      rust = { 'rustfmt' },
      go = { 'gofmt' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      fish = { 'fish_indent' },
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    
    -- Set default options
    default_format_opts = {
      lsp_fallback = true,
    },
    
    -- Set up format-on-save
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      
      -- Disable for certain filetypes
      local filetype = vim.bo[bufnr].filetype
      if vim.tbl_contains({ 'sql', 'java' }, filetype) then
        return
      end
      
      -- Format with timeout and async
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
    
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' }, -- Use 2 spaces for indentation
      },
      prettier = {
        prepend_args = { '--tab-width', '2' },
      },
      prettierd = {
        prepend_args = { '--tab-width', '2' },
      },
    },
    
    -- Set up format after save (for some formatters that need it)
    format_after_save = {
      lsp_fallback = true,
    },
  },
  
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    
    -- Create commands for toggling format-on-save
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
    
    -- Create a command to format the current buffer
    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.count - 1, args.count, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format({ async = true, lsp_fallback = true, range = range })
    end, {
      desc = 'Format current buffer',
      range = true,
    })
  end,
}