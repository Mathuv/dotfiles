return {
  -- Import plugin configurations
  require("plugins.configs.wilder"),
  require("plugins.configs.nvim-tree"),
  require("plugins.configs.dadbod"),
  require("plugins.configs.coc"),
  require("plugins.configs.theme"),

  -- UI and Appearance
  { "lifepillar/vim-gruvbox8" },
  { "junegunn/seoul256.vim" },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- File Navigation and Search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    cmd = "Telescope"
  },
  { "stevearc/oil.nvim" },

  -- Code Editing and Navigation
  { "numToStr/Comment.nvim", event = "VeryLazy" },
  { "jiangmiao/auto-pairs" },
  { "tpope/vim-surround" },
  { "mg979/vim-visual-multi", branch = "master" },
  { "phaazon/hop.nvim", event = "VeryLazy" },
  { "ggandor/leap.nvim", event = "VeryLazy" },
  { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
  
  -- Git Integration
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "junegunn/gv.vim", dependencies = { "tpope/vim-fugitive" } },
  { "airblade/vim-gitgutter" },

  -- Snippets and Completion
  { "SirVer/ultisnips" },
  { "honza/vim-snippets" },
  { "github/copilot.vim" },

  -- Language Support and Formatting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor"
    }
  },
  { "sbdchd/neoformat" },
  { "psf/black", branch = "main" },
  { "mhartington/formatter.nvim" },
  { "editorconfig/editorconfig-vim" },

  -- Markdown and Documentation
  { "plasticboy/vim-markdown" },
  { "wlemuel/vim-tldr" },

  -- Terminal and REPL
  { "jpalardy/vim-slime" },

  -- Utility
  { "folke/which-key.nvim", event = "VeryLazy" },
  { "sudormrfbin/cheatsheet.nvim" },
  { "preservim/tagbar" },
  { "ludovicchabant/vim-gutentags" },
  { "mhinz/vim-startify" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-dotenv" },
  { "janko-m/vim-test" },
  { "mfussenegger/nvim-dap" },
  { "simeji/winresizer" },
  { "folke/zen-mode.nvim" },
  { "christoomey/vim-system-copy" },
  { "tpope/vim-repeat" },
  { "mechatroner/rainbow_csv" },
  { "liuchengxu/vista.vim" },
}
