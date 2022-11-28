-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = colors.black },
    -- z = { fg = colors.white, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

-- lualine defines two kinds of separators:
--     section_separators - separators between sections
--     component_separators - separators between the different components in sections
require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    -- component_separators = { left = '', right = ''},
    section_separators = { left = '', right = '' }, -- Disabling separators
    -- section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {
      { 'mode',
        separator = { left = '' }, -- disable separators
        -- separator = { left = '', right = ''},
        padding = { left = 1, right = 1 } -- Padding can be specified to left or right independently
      },
    },
    lualine_b = {
      {
        'filename',
        file_status = true,      -- Displays file status (readonly status, modified status)
        newfile_status = false,   -- Display new file status (new file means no write after created)
        path = 0,                -- 0: Just the filename
                                 -- 1: Relative path
                                 -- 2: Absolute path
                                 -- 3: Absolute path, with tilde as the home directory

        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                                 -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]',     -- Text to show for new created file before first writting
        },
      },
      'branch' },
    lualine_c = {
      {
        'fileformat',
        symbols = {
                unix = '', -- e712
                dos = '',  -- e70f
                mac = '',  -- e711
        },
      },
    },
    lualine_x = { require('auto-session-library').current_session_name },
    lualine_y = {
      {
        'filetype',
        colored = true,   -- Displays filetype icon in color if set to true
        icon_only = false, -- Display only an icon for filetype
        icon = { align = 'left' }, -- Display filetype icon on the right hand side
        -- icon =    {'X', align='right'}
        -- Icon string ^ in table is ignored in filetype component
      },
      'progress',
    },
    lualine_z = {
      {
        'location',
        padding = { left = 2, right = 2 }
     },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
