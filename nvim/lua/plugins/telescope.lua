return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.4',
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("utils").on_plugin_load("telescope.nvim", function()
          require("telescope").load_extension("fzf")
        end)
      end,
    },
    'nvim-lua/plenary.nvim'
  },
  keys = {
    {"<leader>t", "<cmd>Telescope find_files<CR>", desc="Find files"},
  }
}
