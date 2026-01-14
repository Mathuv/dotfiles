call plug#begin('~/.local/share/nvim/plugged')

Plug 'asvetliakov/vim-easymotion'
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sbdchd/neoformat'
Plug 'psf/black', { 'branch': 'main' }
Plug 'brentyi/isort.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'chriskempson/base16-vim'
" Displays function signatures from completions
Plug 'Shougo/echodoc.vim'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'numToStr/Comment.nvim' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" replace with lualine and bufferline
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
" clolorscheme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-gruvbox8'
Plug 'ryanoasis/vim-devicons'
Plug 'psliwka/vim-smoothie'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'plasticboy/vim-markdown'
Plug 'editorconfig/editorconfig-vim'
" To have ipython like feature within vim
Plug 'jpalardy/vim-slime'
"integration with dash
Plug 'rizzatti/dash.vim'
Plug 'pechorin/any-jump.nvim'
" Case sensitive find and replace
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
Plug 'tpope/vim-speeddating'
Plug 'rhysd/vim-grammarous'
Plug 'tpope/vim-unimpaired'
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'tpope/vim-obsession'
Plug 'ervandew/supertab'
Plug 'elzr/vim-json'
Plug 'wlemuel/vim-tldr'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" 20210529 Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" 20210529 Popup show the keyboard shortcut
Plug 'folke/which-key.nvim'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'preservim/tagbar'
" Plug 'phaazon/hop.nvim'
Plug 'smoka7/hop.nvim'
Plug 'kshenoy/vim-signature'
" Start up screen
Plug 'mhinz/vim-startify'
"For better commit message intrface
" Disabled for neovim terminal
" Plug 'rhysd/committia.vim'
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dotenv'
Plug 'janko-m/vim-test'
Plug 'mfussenegger/nvim-dap'
"TODO: you may want to remap the key away from <C-E> to reclaim cursor key
Plug 'simeji/winresizer'
Plug 'romainl/vim-devdocs'
Plug 'tweekmonster/startuptime.vim'
Plug 'mhartington/formatter.nvim'
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'
endif
Plug 'Xuyuanp/scrollbar.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'github/copilot.vim'
Plug 'tpope/vim-repeat'
Plug 'ggandor/leap.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'christoomey/vim-system-copy'
Plug 'fladson/vim-kitty'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'Vigemus/iron.nvim'
Plug 'mechatroner/rainbow_csv'
Plug 'folke/zen-mode.nvim'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'antoinemadec/coc-fzf'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'liuchengxu/vista.vim'
Plug 'stevearc/oil.nvim'
" Plug 'zbirenbaum/copilot.lua'
Plug 'olimorris/codecompanion.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'Exafunction/windsurf.vim', { 'branch': 'main' }
" Disabled to later use it with more configurations
" Plug 'folke/twilight.nvim'
" Plug 'stevearc/oil.nvim'
" opencode.nvim - AI assistant integration
Plug 'folke/snacks.nvim'
Plug 'NickvanDyke/opencode.nvim'
" Initialize plugin system
" plugend
call plug#end()
