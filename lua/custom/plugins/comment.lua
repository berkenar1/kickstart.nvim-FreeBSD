-- Comment.nvim - Smart and powerful comment plugin for Neovim
-- https://github.com/numToStr/Comment.nvim
--
-- Comment.nvim provides an easy way to comment/uncomment lines and blocks
-- of code with support for multiple languages and treesitter integration.

return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Enable comment string detection via treesitter
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  keys = {
    -- Normal mode mappings
    { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
    { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
    { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
    { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
    { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
    { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },
    
    -- Additional useful mappings
    { '<leader>/', mode = { 'n', 'v' }, desc = 'Comment toggle' },
  },
  config = function()
    -- Import comment plugin safely
    local comment = require('Comment')
    
    -- Enable Comment.nvim
    comment.setup({
      -- Add a space b/w comment and the line
      padding = true,
      
      -- Whether the cursor should stay at its position
      sticky = true,
      
      -- Lines to be ignored while (un)comment
      ignore = nil,
      
      -- LHS of toggle mappings in NORMAL mode
      toggler = {
        line = 'gcc', -- Line-comment toggle keymap
        block = 'gbc', -- Block-comment toggle keymap
      },
      
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        line = 'gc', -- Line-comment keymap
        block = 'gb', -- Block-comment keymap
      },
      
      -- LHS of extra mappings
      extra = {
        above = 'gcO', -- Add comment on the line above
        below = 'gco', -- Add comment on the line below
        eol = 'gcA', -- Add comment at the end of line
      },
      
      -- Enable keybindings
      -- NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        extra = true, -- Extra mapping; `gco`, `gcO`, `gcA`
      },
      
      -- Function to call before (un)comment
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == 'typescriptreact' then
          local U = require('Comment.utils')
          
          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'
          
          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.blockwise then
            location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
          end
          
          return require('ts_context_commentstring.internal').calculate_commentstring({
            key = type,
            location = location,
          })
        end
      end,
      
      -- Function to call after (un)comment
      post_hook = nil,
    })
    
    -- Additional keymaps for easier access
    local api = require('Comment.api')
    vim.keymap.set('n', '<leader>/', api.toggle.linewise.current, { desc = 'Comment toggle current line' })
    
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.keymap.set('x', '<leader>/', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.toggle.linewise(vim.fn.visualmode())
    end, { desc = 'Comment toggle linewise (visual)' })
  end,
}