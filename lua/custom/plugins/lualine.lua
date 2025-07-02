-- Lualine - A blazing fast and easy to configure Neovim statusline
-- https://github.com/nvim-lualine/lualine.nvim
--
-- Lualine provides a beautiful and informative statusline that shows
-- file information, git status, LSP diagnostics, and more.

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'catppuccin', -- Matches our colorscheme
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true, -- Use global statusline
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            return str:sub(1, 1) -- Only show first character of mode
          end,
        }
      },
      lualine_b = {
        'branch',
        {
          'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic', 'nvim_lsp' },
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        }
      },
      lualine_c = {
        {
          'filename',
          file_status = true,     -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 1,               -- 0: Just the filename
                                  -- 1: Relative path
                                  -- 2: Absolute path
                                  -- 3: Absolute path, with tilde as the home directory
                                  -- 4: Filename and parent dir, with tilde as the home directory
          shorting_target = 40,   -- Shortens path to leave 40 spaces in the window
          symbols = {
            modified = '[+]',      -- Text to show when the file is modified.
            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]',     -- Text to show for newly created file before first write
          }
        }
      },
      lualine_x = {
        {
          'searchcount',
          maxcount = 999,
          timeout = 500,
        },
        'encoding',
        'fileformat',
        'filetype'
      },
      lualine_y = {
        'progress'
      },
      lualine_z = {
        'location'
      }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
      'neo-tree',
      'lazy',
      'mason',
      'trouble',
    }
  }
}