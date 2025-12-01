return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true, -- Let Ruff handle this
            analysis = {
              -- THIS IS THE IMPORTANT SETTING
              -- "workspace" = analyzes everything (slow)
              -- "openFilesOnly" = analyzes only what you see (fast)
              diagnosticMode = "openFilesOnly",
              -- Disable things Ruff handles better
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      },
    },
  },
}
