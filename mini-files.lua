return {
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup {
        vim.keymap.set('n', '<leader>e', function()
          if not MiniFiles.close() then
            MiniFiles.open(vim.api.nvim_buf_get_name(0))
          end
        end, { desc = 'Toggle [E]xplorer' }),
      }
    end,
  },
}
