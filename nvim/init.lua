require("config.lazy")


vim.cmd([[colorscheme tokyonight]])

-- General
vim.opt.compatible = false
vim.opt.history = 700
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
vim.opt.showmode = false
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

-- Buffers
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { silent = true })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end
})


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
 vim.lsp.handlers.hover, {
   border = "single",
 }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
 vim.lsp.handlers.signature_help, {
   border = "single"
 }
)
