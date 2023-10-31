return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.4',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {"<leader>t", "<cmd>Telescope find_files<CR>", desc="Find files"},
  }
}
