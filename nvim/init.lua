require("config.lazy")

vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- General
vim.opt.history = 700
vim.opt.compatible = false
vim.opt.hidden = true

vim.opt.autoread = true
vim.opt.autowrite = true

-- UI
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.mat = 2
vim.opt.completeopt:remove { "preview" }

-- Formatting
vim.opt.shiftwidth=2
vim.opt.tabstop=2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.listchars = "tab:>-"
vim.opt.list = true

-- Navigation
vim.opt.mouse = ""

vim.api.nvim_set_keymap("i", "<Up>", "<NOP>", { silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<Up>", "<NOP>", { silent = true, noremap = true})
vim.api.nvim_set_keymap("i", "<Down>", "<NOP>", { silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<Down>", "<NOP>", { silent = true, noremap = true})
vim.api.nvim_set_keymap("i", "<Left>", "<NOP>", { silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<Left>", "<NOP>", { silent = true, noremap = true})
vim.api.nvim_set_keymap("i", "<Right>", "<NOP>", { silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<Right>", "<NOP>", { silent = true, noremap = true})

vim.api.nvim_set_keymap("n", "j", "gj", { silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { silent = true })

-- Make MiniSurround work like vim-surround.
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
