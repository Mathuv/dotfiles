let g:airline#extensions#tabline#enabled = 1

"To show the buffer no next to file name
"https://jdhao.github.io/2018/09/29/Switching_buffers_quickly_Neovim/
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

set background=dark

let g:airline_theme = 'catppuccin'

lua << EOF
require("catppuccin").setup({
    flavour = "auto",
    background = {
        light = "latte",
        dark = "mocha",
    },
    default_integrations = true,
    auto_integrations = false,
    integrations = {
        hop = true,
        leap = true,
        nvimtree = true,
        which_key = true,
        telescope = { enabled = true },
        indent_blankline = { enabled = true },
        snacks = { enabled = true },
    },
    highlight_overrides = {
        mocha = function(mocha)
            return {
                DiffAdd = { fg = "#e6edf3", bg = "#003800" },
                DiffDelete = { fg = "#e6edf3", bg = "#3f0001" },
                DiffChange = { fg = "#e6edf3", bg = "#1d3042" },
                DiffText = { fg = "#ffffff", bg = "#2a4556", bold = true },
                GitSignsAdd = { fg = "#3fb950", bold = true },
                GitSignsChange = { fg = "#d29922", bold = true },
                GitSignsDelete = { fg = "#f85149", bold = true },
                GitSignsTopdelete = { fg = "#f85149", bold = true },
                GitSignsChangedelete = { fg = "#d29922", bold = true },
                GitSignsUntracked = { fg = "#3fb950", bold = true },
            }
        end,
        latte = function(latte)
            return {
                GitSignsAdd = { fg = "#1a7f37", bold = true },
                GitSignsChange = { fg = "#9a6700", bold = true },
                GitSignsDelete = { fg = "#cf222e", bold = true },
                GitSignsTopdelete = { fg = "#cf222e", bold = true },
                GitSignsChangedelete = { fg = "#9a6700", bold = true },
                GitSignsUntracked = { fg = "#1a7f37", bold = true },
            }
        end,
    },
})
EOF

colorscheme catppuccin
