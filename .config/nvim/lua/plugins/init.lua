-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Helper function for conditional plugin loading
_G.Cond = function(condition, ...)
    local opts = select(1, ...) or {}
    return condition and opts or vim.tbl_extend('force', opts, {
        enabled = false,
        cond = false
    })
end

-- Plugin specifications
return require("lazy").setup({
    -- Core plugins
    { "nathom/filetype.nvim" },
    { "asvetliakov/vim-easymotion", cond = vim.g.vscode ~= nil },

    -- Search and navigation
    { dir = "/opt/homebrew/opt/fzf" },
    { "junegunn/fzf.vim", dependencies = { "/opt/homebrew/opt/fzf" } },

    -- Code editing
    { "jiangmiao/auto-pairs" },
    { "sbdchd/neoformat" },
    { "psf/black", branch = "main" },
    { "brentyi/isort.vim" },
    { "machakann/vim-highlightedyank" },

    -- VSCode-excluded plugins
    Cond(vim.g.vscode == nil, {
        -- LSP and completion
        { "neoclide/coc.nvim", branch = "release" },
        
        -- Git integration
        { "airblade/vim-gitgutter" },
        { "tpope/vim-fugitive" },
        { "junegunn/gv.vim", dependencies = { "tpope/vim-fugitive" } },
        { "tpope/vim-rhubarb" },
        
        -- UI and themes
        { "vim-airline/vim-airline" },
        { "vim-airline/vim-airline-themes", dependencies = { "vim-airline/vim-airline" } },
        { "dracula/vim", name = "dracula" },
        { "lifepillar/vim-gruvbox8" },
        
        -- Code editing and navigation
        { "ludovicchabant/vim-gutentags" },
        { "numToStr/Comment.nvim", config = true },
        { "mg979/vim-visual-multi", branch = "master" },
        { "tpope/vim-surround" },
        { "tpope/vim-unimpaired" },
        
        -- Grammar checking
        { "rhysd/vim-grammarous" },
        
        -- Must be last
        { "ryanoasis/vim-devicons" }
    }),
}, {
    defaults = {
        lazy = true, -- Load plugins lazily by default
    },
    install = {
        colorscheme = { "dracula" },
    },
    checker = {
        enabled = true, -- Automatically check for plugin updates
        notify = false, -- Don't show update notifications
    },
    change_detection = {
        notify = false, -- Don't show config change notifications
    },
})
