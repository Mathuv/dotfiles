local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      }
    },
    -- How the repl window will be displayed
    -- See below for more information
    -- repl_open_cmd = require('iron.view').bottom(40),
    -- repl_open_cmd = view.split.vertical.botright(50)
    -- repl_open_cmd = view.split.vertical.botright(0.4)
    repl_open_cmd = view.split.vertical(0.4)
    -- repl_open_cmd = view.split("40%")

  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space>isc",
    visual_send = "<space>isc",
    send_file = "<space>isf",
    send_line = "<space>isl",
    send_mark = "<space>ism",
    mark_motion = "<space>imc",
    mark_visual = "<space>imc",
    remove_mark = "<space>imd",
    cr = "<space>is<cr>",
    interrupt = "<space>is<space>",
    exit = "<space>isq",
    clear = "<space>icl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>irs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>irr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>irf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>irh', '<cmd>IronHide<cr>')
