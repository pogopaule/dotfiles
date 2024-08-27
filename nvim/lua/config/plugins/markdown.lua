return {
  -- Preview markdown, requires live-preview and pandoc to be installed
  {
    'https://github.com/iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    keys = {
      { '<leader>tm', '<CMD>MarkdownPreviewToggle<CR>', desc = 'Markdown Preview' },
    },
    ft = { 'markdown' },
    build = function() vim.fn['mkdp#util#install']() end,
  },
}
