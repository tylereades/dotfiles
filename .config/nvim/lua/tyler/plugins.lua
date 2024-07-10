local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)

  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"

  use "nvim-lua/popup.nvim"

  use "christoomey/vim-tmux-navigator"

  use "folke/tokyonight.nvim"
  use "rebelot/kanagawa.nvim"
  use "uloco/bluloco.nvim"
  use "rktjmp/lush.nvim"

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"

  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  use "simrat39/rust-tools.nvim"

  use "jose-elias-alvarez/null-ls.nvim"
  use "RRethy/vim-illuminate"

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
  'nvim-telescope/telescope.nvim',
  requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim'}
    }
  }

  use "nvim-treesitter/nvim-treesitter"
  use "RRethy/nvim-treesitter-textsubjects"

  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  use "lewis6991/gitsigns.nvim"

  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"

  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"

  use "akinsho/toggleterm.nvim"

  use { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }

  -- Others to maybe setup
  -- use "ahmedkhalf/project.nvim"
  use "windwp/nvim-ts-autotag"
  use "windwp/nvim-autopairs"
  -- use "lewis6991/impatient.nvim"
  use "folke/which-key.nvim"
  use "goolord/alpha-nvim"

  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
