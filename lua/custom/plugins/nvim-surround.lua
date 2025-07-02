-- nvim-surround - Add/change/delete surrounding delimiter pairs with ease
-- https://github.com/kylechui/nvim-surround
--
-- nvim-surround provides an easy way to add, change, and delete surrounding
-- characters like quotes, parentheses, brackets, and more. It's inspired by
-- vim-surround but built specifically for Neovim with Lua.

return {
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup({
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        insert = '<C-g>s',
        insert_line = '<C-g>S',
        normal = 'ys',
        normal_cur = 'yss',
        normal_line = 'yS',
        normal_cur_line = 'ySS',
        visual = 'S',
        visual_line = 'gS',
        delete = 'ds',
        change = 'cs',
        change_line = 'cS',
      },
      
      -- Define custom surrounds
      surrounds = {
        -- Example: Add custom surrounds for function calls
        ['f'] = {
          add = function()
            local config = require('nvim-surround.config')
            local result = config.get_input('Enter the function name: ')
            if result then
              return { { result .. '(' }, { ')' } }
            end
          end,
          find = function()
            return config.get_selection({ motion = 'af' })
          end,
          delete = '^(.-)%(().-%)()$',
          change = {
            target = '^(.-)%(().-%)()$',
            replacement = function()
              local config = require('nvim-surround.config')
              local result = config.get_input('Enter the function name: ')
              if result then
                return { { result .. '(' }, { ')' } }
              end
            end,
          },
        },
        
        -- Add custom surrounds for HTML tags
        ['t'] = {
          add = function()
            local config = require('nvim-surround.config')
            local result = config.get_input('Enter the tag name: ')
            if result then
              return { { '<' .. result .. '>' }, { '</' .. result .. '>' } }
            end
          end,
          find = function()
            return config.get_selection({ motion = 'at' })
          end,
          delete = '^<(.-)>().-</%1>()$',
          change = {
            target = '^<(.-)>().-</.->()$',
            replacement = function()
              local config = require('nvim-surround.config')
              local result = config.get_input('Enter the tag name: ')
              if result then
                return { { '<' .. result .. '>' }, { '</' .. result .. '>' } }
              end
            end,
          },
        },
      },
      
      -- Aliases for common surrounds
      aliases = {
        ['a'] = '>',    -- Angle brackets
        ['b'] = ')',    -- Parentheses
        ['B'] = '}',    -- Braces
        ['r'] = ']',    -- Square brackets
        ['q'] = { '"', "'", '`' }, -- Any quote
        ['s'] = { '}', ')', ']', '>', '"', "'", '`' }, -- Any surrounding delimiter
      },
      
      -- Highlight the surround for better visual feedback
      highlight = {
        duration = 0,
      },
      
      -- Move cursor behavior
      move_cursor = 'begin',
      
      -- Indentation behavior
      indent_lines = function(start, stop)
        local b = vim.bo
        -- Only re-indent the selection if a formatter is set up already
        if start < stop and (b.equalprg ~= '' or b.indentexpr ~= '' or b.cindent or b.smartindent or b.lisp) then
          vim.cmd(string.format('silent normal! %dG=%dG', start, stop))
        end
      end,
    })
  end,
  
  -- Add which-key descriptions for the mappings
  init = function()
    -- Only set up which-key descriptions if which-key is available
    local ok, wk = pcall(require, 'which-key')
    if ok then
      wk.register({
        ['ys'] = 'Add surround',
        ['yss'] = 'Add surround to line',
        ['yS'] = 'Add surround to line (insert newlines)',
        ['ySS'] = 'Add surround to current line (insert newlines)',
        ['ds'] = 'Delete surround',
        ['cs'] = 'Change surround',
        ['cS'] = 'Change surround (insert newlines)',
      }, { mode = 'n' })
      
      wk.register({
        ['S'] = 'Add surround',
        ['gS'] = 'Add surround (insert newlines)',
      }, { mode = 'v' })
    end
  end,
}