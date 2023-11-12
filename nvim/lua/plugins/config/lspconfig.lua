return function(_, _)
	require("lspconfig").lua_ls.setup({
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	})

	-- Python
	require("lspconfig").pyright.setup({})
	require("lspconfig").pyre.setup({})

	-- Golang
	require("lspconfig").gopls.setup({})

	-- Rust
	require("lspconfig").rust_analyzer.setup({})
end
