local options = {
  backup = false,                         -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                          -- more space in the neovim command line for displaying messages
  completeopt = {"menuone", "noselect"},  -- Completion options (for deoplete)
  conceallevel = 0,                       -- so that `` is visible in markdown files
  fileencoding = "utf-8",                 -- the encoding written to a file
  hlsearch = true,                        -- highlight all matches on previous search pattern
  ignorecase = true,                      -- Ignore case
  mouse = "a",                            -- Enable mouse mode
  pumheight = 10,                         -- pop up menu height
  showmode = false,                       -- don't need to see things like -- INSERT -- anymore
  showtabline = 2,                        -- always show tabs
  smartcase = true,                       -- Do not ignore case with capitals
  smartindent = true,                     -- Insert indents automatically
  splitbelow = true,                      -- Put new windows below current
  splitright = true,                      -- Put new windows right of current
  swapfile = false,                       -- creates a swapfile
  timeoutlen = 300,                       -- time to wait for a mpaped sequence to complete (in milliseconds)
  undofile = true,                        -- Save undo history
  updatetime = 250,                       -- Decrease update time
  writebackup = false,                    -- if a file is being edited by another program, it is not allowed to be edited
  expandtab = true,                       -- Use spaces instead of tabs
  shiftwidth = 2,                         -- Size of an indent
  tabstop = 2,                            -- Number of spaces tabs count for
  cursorline = true,                      -- highlight the current line
  number = true,                          -- Show line numbers
  relativenumber = true,                  -- Relative line numbers
  hidden = true,                          -- Enable background buffers
  signcolumn = "yes",                     -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                           -- display lines as one long line
  linebreak = true,                       -- companion to wrap, don't split words
  scrolloff = 8,                          -- Lines of context
  sidescrolloff = 8,                      -- Columns of context
  termguicolors = true                    -- True color support
  --breakindent = true                    -- Enable break indent
  --vim.cmd [[colorscheme onedark]]
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

