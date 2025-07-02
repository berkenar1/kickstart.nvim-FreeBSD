-- Catppuccin colorscheme - A modern, beautiful, and feature-rich theme
-- https://github.com/catppuccin/nvim
--
-- Catppuccin is a community-driven pastel theme that aims to be the middle ground
-- between low and high contrast themes. It provides excellent syntax highlighting
-- and integrates well with many popular plugins.

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Make sure to load this before all the other start plugins
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = false, -- disables setting the background color
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = 'dark',
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { 'italic' }, -- Change the style of comments
      conditionals = { 'italic' },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = '',
      },
      -- Integrations with other plugins we'll be adding
      telescope = {
        enabled = true,
        -- style = "nvchad"
      },
      lsp_trouble = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    
    -- Set the colorscheme
    -- NOTE: You can change this to any other colorscheme available
    -- Popular alternatives include: 'tokyonight', 'gruvbox', 'nord', 'onedark'
    vim.cmd.colorscheme 'catppuccin'
  end,
}