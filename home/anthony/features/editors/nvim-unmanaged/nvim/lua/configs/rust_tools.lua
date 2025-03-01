local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local rt = require "rust-tools"

rt.setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          enable = true,
          command = "check",
          extraArgs = {
            "--target-dir", "/home/anthony/.rust-analyzer",
          }
        }
      }
    }
  }
})
