vim.opt.termguicolors = true

require("config.lazy")

vim.cmd([[colorscheme tokyonight]])

-- General
vim.opt.compatible = false
vim.opt.history = 700
vim.opt.hidden = true
vim.opt.splitright = true

-- UI
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.mat = 2
vim.opt.showmode = false
vim.opt.completeopt:remove({ "preview" })

-- Formatting
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false

vim.opt.listchars = "tab:-->"
vim.opt.list = true

vim.api.nvim_create_user_command("FormatDisable", function(_)
	---@diagnostic disable-next-line: inject-field
	vim.g.disable_autoformat = true
end, {
	desc = "Disable autoformatting",
})

vim.api.nvim_create_user_command("FormatEnable", function(_)
	---@diagnostic disable-next-line: inject-field
	vim.g.disable_autoformat = false
end, {
	desc = "Disable autoformatting",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = {
		"*/GRAPHITE_PR_DESCRIPTION.md",
	},
	command = "set tw=72",
})

-- Navigation
vim.opt.mouse = ""

vim.api.nvim_set_keymap("i", "<Up>", "<NOP>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<Up>", "<NOP>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<Down>", "<NOP>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<Down>", "<NOP>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<Left>", "<NOP>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<Left>", "<NOP>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<Right>", "<NOP>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<Right>", "<NOP>", { silent = true, noremap = true })

vim.api.nvim_set_keymap("n", "j", "gj", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { silent = true, noremap = true })

-- Make MiniSurround work like vim-surround.
vim.keymap.del("x", "ys")
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- Buffers
vim.keymap.set("n", "<leader>bd", function()
	require("mini.bufremove").delete(0)
end, { desc = "Delete buffer", silent = true })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local opts = { buffer = args.buf }
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client ~= nil and client.server_capabilities.inlayHintProvider then
			vim.keymap.set("n", "<leader>hi", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end, vim.tbl_extend("error", opts, { desc = "Toggle inlay hints" }))
		end

		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("error", opts, { desc = "Hover" }))
		vim.keymap.set(
			{ "i", "n" },
			"<C-k>",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("error", opts, { desc = "Signature help" })
		)
		vim.keymap.set("n", "<leader>ts", function()
			require("telescope.builtin").lsp_document_symbols({
				symbol_width = 50,
				symbols = { "class", "struct", "enum", "function", "method", "constant" },
			})
		end, vim.tbl_extend("error", opts, { desc = "Find symbol" }))
		vim.keymap.set("n", "gd", function()
			require("telescope.builtin").lsp_definitions({
				reuse_win = true,
				show_line = false,
				path_display = { "tail" },
			})
		end, vim.tbl_extend("error", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references({
				reuse_win = true,
				show_line = false,
				path_display = { "tail" },
			})
		end, vim.tbl_extend("error", opts, { desc = "Go to references" }))
		vim.keymap.set("n", "gI", function()
			require("telescope.builtin").lsp_implementations({
				reuse_win = true,
				show_line = false,
				path_display = { "tail" },
			})
		end, vim.tbl_extend("error", opts, { desc = "Go to implementations" }))
		vim.keymap.set(
			"n",
			"<leader>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("error", opts, { desc = "Code actions" })
		)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("error", opts, { desc = "Rename" }))
	end,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = false,
	signs = true,
})

-- Pyre is noisy.
vim.lsp.set_log_level("off")
