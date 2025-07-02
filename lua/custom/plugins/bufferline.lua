-- Bufferline - A snazzy buffer line for Neovim
-- https://github.com/akinsho/bufferline.nvim
--
-- Bufferline provides beautiful tabs that show your open buffers,
-- making it easier to navigate between multiple files.

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle [B]uffer [P]in' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-[P]inned [B]uffers' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete [O]ther [B]uffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete [B]uffers to the [R]ight' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete [B]uffers to the [L]eft' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev [B]uffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next [B]uffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move [B]uffer Prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move [B]uffer Next' },
  },
  opts = {
    options = {
      close_command = 'bdelete! %d',
      right_mouse_command = 'bdelete! %d',
      left_mouse_command = 'buffer %d',
      middle_mouse_command = nil,
      indicator = {
        icon = '▎', -- this should be omitted if indicator style is not 'icon'
        style = 'icon',
      },
      buffer_close_icon = '󰅖',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 30,
      max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
      tab_size = 21,
      diagnostics = 'nvim_lsp',
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match('error') and ' ' or ' '
        return ' ' .. icon .. count
      end,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      separator_style = 'slant',
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      sort_by = 'insert_after_current',
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
    highlights = {
      -- Integration with catppuccin theme
      fill = {
        fg = { attribute = 'fg', highlight = '#181825' },
        bg = { attribute = 'bg', highlight = '#181825' },
      },
      background = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      buffer_selected = {
        fg = { attribute = 'fg', highlight = 'TabLineSel' },
        bg = { attribute = 'bg', highlight = 'TabLineSel' },
        bold = true,
        italic = true,
      },
      buffer_visible = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      close_button = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      close_button_visible = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      close_button_selected = {
        fg = { attribute = 'fg', highlight = 'TabLineSel' },
        bg = { attribute = 'bg', highlight = 'TabLineSel' },
      },
      tab_selected = {
        fg = { attribute = 'fg', highlight = 'Normal' },
        bg = { attribute = 'bg', highlight = 'Normal' },
      },
      tab = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      tab_close = {
        fg = { attribute = 'fg', highlight = 'TabLineSel' },
        bg = { attribute = 'bg', highlight = 'Normal' },
      },
      duplicate_selected = {
        fg = { attribute = 'fg', highlight = 'TabLineSel' },
        bg = { attribute = 'bg', highlight = 'TabLineSel' },
        italic = true,
      },
      duplicate_visible = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
        italic = true,
      },
      duplicate = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
        italic = true,
      },
      modified = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      modified_selected = {
        fg = { attribute = 'fg', highlight = 'Normal' },
        bg = { attribute = 'bg', highlight = 'Normal' },
      },
      modified_visible = {
        fg = { attribute = 'fg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      separator = {
        fg = { attribute = 'bg', highlight = 'TabLine' },
        bg = { attribute = 'bg', highlight = 'TabLine' },
      },
      separator_selected = {
        fg = { attribute = 'bg', highlight = 'Normal' },
        bg = { attribute = 'bg', highlight = 'Normal' },
      },
      indicator_selected = {
        fg = { attribute = 'fg', highlight = 'LspDiagnosticsDefaultHint' },
        bg = { attribute = 'bg', highlight = 'Normal' },
      },
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd('BufAdd', {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}