local servers = {
	"lua_ls",
	"rust_analyzer",
	"cssls",
	"html",
	"tsserver",
	"bashls",
	"jsonls",
	"yamlls",
  "jdtls",
  "pyright",
  "svelte",
  --"terraform-ls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

local util = require("lspconfig/util")

for _, server in pairs(servers) do
  opts = {
    on_attach = require("tyler.lsp.handlers").on_attach,
    capabilities = require("tyler.lsp.handlers").capabilities,
  }
  if server == "pyright" then
    opts.root_dir = function(fname)
      return util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
        util.path.dirname(fname)
    end
  end

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "tyler.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
