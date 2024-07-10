local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "tyler.lsp.mason"
require("tyler.lsp.handlers").setup()
require "tyler.lsp.null-ls"
