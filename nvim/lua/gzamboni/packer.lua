-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Install Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }

  -- Install TokyoNight ColorScheme
  use({
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
      vim.cmd.colorscheme('tokyonight-night')
    end

  })

  -- Install TreeSitter
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  -- Install Undo Tree
  use('mbbill/undotree')

  -- Install LSP Zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- Install .editorconfig support
  use('gpanders/editorconfig.nvim')

  -- Install GitHub Copilot
  use('github/copilot.vim', {
    config = function()
      vim.g.copilot_autostart = 1
    end
  })

  -- Install nvim-tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Install nvim-hardline
  use { 'ojroques/nvim-hardline' }

  -- Install BufferLine
  use { 'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = {
      'nvim-tree/nvim-web-devicons',
      'famiu/bufdelete.nvim'
    }
  }

  -- Install nvim-autopairs
  use 'windwp/nvim-autopairs'

  -- Install nvim-comment
  use 'terrortylor/nvim-comment'

  -- Install fugitive
  use 'tpope/vim-fugitive'

  -- Install renamer
  use {
    'filipdutescu/renamer.nvim',
    branch = 'master',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
