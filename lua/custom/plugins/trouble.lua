-- Trouble.nvim - A pretty diagnostics, references, telescope results, quickfix and location list
-- https://github.com/folke/trouble.nvim
--
-- Trouble provides a beautiful and organized way to view diagnostics, references,
-- and other lists in Neovim. It's particularly useful for navigating errors and warnings.

return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
  opts = {
    auto_close = false, -- auto close when there are no items
    auto_open = false, -- auto open when there are items
    auto_preview = true, -- automatically open preview when on an item
    auto_refresh = true, -- auto refresh when open
    auto_jump = false, -- auto jump to the item when there's only one
    focus = false, -- Focus the window when opened
    restore = true, -- restores the last location in the list when opened
    follow = true, -- Follow the current item
    indent_guides = true, -- show indent guides
    max_items = 200, -- limit number of items that can be displayed per section
    multiline = true, -- render multi-line messages
    pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
    warn_no_results = true, -- show a warning when there are no results
    open_no_results = false, -- open the trouble window when there are no results
    
    -- Window configuration
    win = {
      size = { width = 0.3, height = 0.3 },
      position = 'bottom', -- position of the window can be: bottom, top, left, right
    },
    
    -- Item preview configuration  
    preview = {
      type = 'split',
      relative = 'win',
      position = 'right',
      size = 0.3,
    },
    
    -- Throttle refresh and processing
    throttle = {
      refresh = 20, -- fetches new data when needed
      update = 10, -- updates the window
      render = 10, -- renders the window
      follow = 100, -- follows the current item
      preview = { ms = 100, debounce = true }, -- preview delay
    },
    
    -- Key mappings in trouble window
    keys = {
      ['?'] = 'help',
      r = 'refresh',
      R = 'toggle_refresh',
      q = 'close',
      o = 'jump_close',
      ['<esc>'] = 'cancel',
      ['<cr>'] = 'jump',
      ['<2-leftmouse>'] = 'jump',
      ['<c-s>'] = 'jump_split',
      ['<c-v>'] = 'jump_vsplit',
      -- go down to next item (accepts count)
      -- j = "next",
      ['}'] = 'next',
      [']]'] = 'next',
      -- go up to previous item (accepts count)
      -- k = "prev", 
      ['{'] = 'prev',
      ['[['] = 'prev',
      dd = 'delete',
      d = { action = 'delete', mode = 'v' },
      i = 'inspect',
      p = 'preview',
      P = 'toggle_preview',
      zo = 'fold_open',
      zO = 'fold_open_recursive',
      zc = 'fold_close',
      zC = 'fold_close_recursive',
      za = 'fold_toggle',
      zA = 'fold_toggle_recursive',
      zm = 'fold_more',
      zM = 'fold_close_all',
      zr = 'fold_reduce',
      zR = 'fold_open_all',
      zx = 'fold_update',
      zX = 'fold_update_all',
      zn = 'fold_disable',
      zN = 'fold_enable',
      zi = 'fold_toggle_enable',
      gb = { -- example of a custom action that toggles the active view filter
        action = function(view)
          view:filter({ buf = 0 }, { toggle = true })
        end,
        desc = 'Toggle Current Buffer Filter',
      },
      s = { -- example of a custom action that toggles the severity
        action = function(view)
          local f = view:get_filter('severity')
          local severity = ((f and f.filter.severity or 0) + 1) % 5
          view:filter({ severity = severity }, {
            id = 'severity',
            template = '{hl:Title}[{severity}]{hl} {count} items',
            del = severity == 0,
          })
        end,
        desc = 'Toggle Severity Filter',
      },
    },
    
    -- Configuration for different modes
    modes = {
      -- Sources data from the LSP client
      lsp = {
        win = { position = 'right' },
      },
    },
    
    -- Configuration for different sources
    sources = {
      lsp_definitions = {
        params = {
          include_current = true,
        },
      },
      lsp_references = {
        params = {
          include_current = true,
        },
      },
      lsp_implementations = {
        params = {
          include_current = true,
        },
      },
      lsp_type_definitions = {
        params = {
          include_current = true,
        },
      },
    },
  },
}