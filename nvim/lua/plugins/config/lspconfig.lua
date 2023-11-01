return function(_, _)
  require("lspconfig").lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  })

  require("lspconfig").pyright.setup({})
  require("lspconfig").pyre.setup({})
end
