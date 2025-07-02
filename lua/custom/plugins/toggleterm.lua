-- ToggleTerm.nvim - A neovim lua plugin to help easily manage multiple terminal windows
-- https://github.com/akinsho/toggleterm.nvim
--
-- ToggleTerm provides an easy way to manage terminal windows within Neovim,
-- with support for floating terminals, tab terminals, and more.

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { 'ToggleTerm', 'TermExec' },
  keys = {
    { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Toggle [T]erminal' },
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Toggle [F]loating Terminal' },
    { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Toggle [H]orizontal Terminal' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', desc = 'Toggle [V]ertical Terminal' },
    { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal', mode = { 'n', 't' } },
  },
  opts = {
    -- Size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    
    open_mapping = [[<c-\>]], -- Key binding to toggle terminal
    hide_numbers = true, -- Hide the number column in toggleterm buffers
    shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor = 2, -- The degree by which to darken to terminal colour
    start_in_insert = true,
    insert_mappings = true, -- Whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- Whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- If set to true (default) the previous terminal mode will be remembered
    direction = 'float', -- Direction: 'vertical' | 'horizontal' | 'tab' | 'float'
    close_on_exit = true, -- Close the terminal when the process exits
    shell = vim.o.shell, -- Change the default shell
    auto_scroll = true, -- Automatically scroll to the bottom on terminal output
    
    -- Float terminal configuration
    float_opts = {
      border = 'curved', -- Border style: 'single' | 'double' | 'shadow' | 'curved' | ... see :h nvim_win_open()
      width = function()
        return math.ceil(vim.o.columns * 0.8)
      end,
      height = function()
        return math.ceil(vim.o.lines * 0.8)
      end,
      winblend = 3,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
    
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
  },
  
  config = function(_, opts)
    require('toggleterm').setup(opts)
    
    -- Set terminal keymaps
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end
    
    -- Apply the keymap when entering a terminal
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    
    -- Create some useful terminal shortcuts
    local Terminal = require('toggleterm.terminal').Terminal
    
    -- Lazygit integration
    local lazygit = Terminal:new({
      cmd = 'lazygit',
      direction = 'float',
      hidden = true,
      float_opts = {
        border = 'curved',
        width = function()
          return math.ceil(vim.o.columns * 0.9)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.9)
        end,
      },
    })
    
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end
    
    -- Node REPL
    local node = Terminal:new({
      cmd = 'node',
      direction = 'float',
      hidden = true,
    })
    
    function _NODE_TOGGLE()
      node:toggle()
    end
    
    -- Python REPL
    local python = Terminal:new({
      cmd = 'python3',
      direction = 'float',
      hidden = true,
    })
    
    function _PYTHON_TOGGLE()
      python:toggle()
    end
    
    -- HTOP
    local htop = Terminal:new({
      cmd = 'htop',
      direction = 'float',
      hidden = true,
    })
    
    function _HTOP_TOGGLE()
      htop:toggle()
    end
    
    -- Create keymaps for the custom terminals
    vim.keymap.set('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = 'LazyGit' })
    vim.keymap.set('n', '<leader>tn', '<cmd>lua _NODE_TOGGLE()<CR>', { desc = 'Node REPL' })
    vim.keymap.set('n', '<leader>tp', '<cmd>lua _PYTHON_TOGGLE()<CR>', { desc = 'Python REPL' })
    vim.keymap.set('n', '<leader>th', '<cmd>lua _HTOP_TOGGLE()<CR>', { desc = 'HTOP' })
    
    -- Terminal number management
    vim.keymap.set('n', '<leader>t1', '<cmd>1ToggleTerm<cr>', { desc = 'Terminal 1' })
    vim.keymap.set('n', '<leader>t2', '<cmd>2ToggleTerm<cr>', { desc = 'Terminal 2' })
    vim.keymap.set('n', '<leader>t3', '<cmd>3ToggleTerm<cr>', { desc = 'Terminal 3' })
    vim.keymap.set('n', '<leader>t4', '<cmd>4ToggleTerm<cr>', { desc = 'Terminal 4' })
  end,
}