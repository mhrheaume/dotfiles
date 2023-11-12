require("config.lazy")


vim.cmd([[colorscheme kanagawa]])

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
vim.opt.smartindent = false

vim.opt.listchars = "tab:>-"
vim.opt.list = true

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

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
vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '[b', ':bprev<CR>', { silent = true })
vim.keymap.set('n', '<leader>bd', function() require('mini.bufremove').delete(0) end, { silent = true })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', function() require("telescope.builtin").lsp_definitions({ reuse_win = true, show_line = false, path_display = { "tail" }}) end, opts)
    vim.keymap.set('n', 'gr', function() require("telescope.builtin").lsp_references({ reuse_win = true, show_line = false, path_display = { "tail" }})  end, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
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

