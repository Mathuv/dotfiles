return {
  "neoclide/coc.nvim",
  branch = "release",
  config = function()
    -- Highlight symbol under cursor on CursorHold
    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "*",
      callback = function()
        vim.fn.CocActionAsync('highlight')
      end,
    })

    -- Set CocHighlightText color after colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.cmd([[highlight CocHighlightText ctermfg=LightMagenta guifg=LightMagenta]])
      end,
    })

    -- Additional CoC configurations can be added here
  end,
}
