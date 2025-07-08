return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- Harpoon status function: prev [current] total

    local function harpoon_status()
      local mark = require 'harpoon.mark'
      local idx = mark.get_current_index()
      local cfg = require('harpoon').get_mark_config()
      local marks = cfg.marks or {}
      local total = #marks
      -- if no marks or current file not marked, show nothing
      if total == 0 or not idx then
        return ''
      end
      -- build list: 1 2 [3] 4 5
      local items = {}
      for i = 1, total do
        if i == idx then
          table.insert(items, '[' .. i .. ']')
        else
          table.insert(items, tostring(i))
        end
      end
      return '                                ' .. table.concat(items, ' ')
    end

    -- Colors and theme (Sonokai transparent)
    local colors = {
      black = '#2b2d3a',
      white = '#e1e3e4',
      red = '#ff6578',
      green = '#A6CD77',
      blue = '#67bfff',
      yellow = '#ffcc66',
      orange = '#f78c6c',
      purple = '#c792ea',
      gray = '#7f8490',
      darkgray = '#363a4e',
      lightgray = '#494b59',
      inactivegray = '#7f8490',
    }
    local sonokai_transparent = {
      normal = {
        a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white },
      },
      insert = {
        a = { bg = colors.green, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white },
      },
      visual = {
        a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white },
      },
      replace = {
        a = { bg = colors.red, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white },
      },
      command = {
        a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white },
      },
      inactive = {
        a = { bg = 'NONE', fg = colors.inactivegray, gui = 'bold' },
        b = { bg = 'NONE', fg = colors.inactivegray },
        c = { bg = 'NONE', fg = colors.inactivegray },
      },
    }

    -- Other components
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end
    local mode = {
      'mode',
      fmt = function(str)
        return ' ' .. str
      end,
      separator = { left = '' },
      right_padding = 2,
    }
    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }
    local diff = { 'diff', colored = false, symbols = { added = ' ', modified = ' ', removed = ' ' }, cond = hide_in_width }

    -- Setup lualine
    require('lualine').setup {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        icons_enabled = true,
        theme = sonokai_transparent,
        disabled_filetypes = { 'alpha', 'snacks_dashboard', 'snacks_picker_list' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = {},
        lualine_c = { '%=', harpoon_status },
        lualine_x = { 'fileformat', 'encoding', { 'filetype', cond = hide_in_width } },
        lualine_y = { 'location' },
        lualine_z = { { 'progress', separator = { right = '' }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'fugitive' },
    }
  end,
}
