return {
  {
    "joshdick/onedark.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.g.onedark_termcolors = 256

      -- Custom background color in terminal
      if vim.fn.has("autocmd") == 1 and vim.fn.has("gui_running") == 0 then
        local background = { gui = "#191c1a", cterm = "235", cterm16 = "0" }
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "*",
          callback = function()
            vim.fn['onedark#set_highlight']("Normal", { bg = background })
          end,
        })
      end

      vim.cmd([[colorscheme onedark]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim", -- replacing vim-airline
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'onedark',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        tabline = {
          lualine_a = {
            {
              'buffers',
              show_filename_only = true,
              show_bufnr = true,
              mode = 2,
            }
          },
        },
      })
    end,
  },
}
