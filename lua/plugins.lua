local packer = require("packer")
packer.startup(
  function(use)
  -- Packer 可以管理自己本身
  use ('wbthomason/packer.nvim')
  ----------- colorschemes ----------
  -- tender
  use("jacoborus/tender.vim")
  -- tokyonight
  use("folke/tokyonight.nvim")
  -----------------------------------
  ----------- plugins ---------------
  -- nvim-tree
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"})
  -- bufferline
  use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye"}})
  -- lualine
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
  use("arkav/lualine-lsp-progress")
  -- treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  -- lspconfig
  use({ "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer"})
  -- telescope (fzf tool)
  use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
  -- dashboard
  use("glepnir/dashboard-nvim")
  -----------------------------------
end
)

-- 每次保存plugins.lua 自动安装插件
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
