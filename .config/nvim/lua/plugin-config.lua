vim.diagnostic.config({ virtual_text = true })
-- nvim-treesitter config (START)


require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  refactor = {
    navigation = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
      keymaps = {
        -- goto_definition = "gnd",
        -- goto_definition_lsp_fallback = "gnd",
        -- list_definitions = "gnD",
        list_definitions_toc = "gO",
        -- goto_next_usage = "<a-*>",
        goto_next_usage = "gnd",
        -- goto_previous_usage = "<a-#>",
        goto_previous_usage = "gnD",
      },
    },
  },
}

require("which-key").setup {}

require('nvim-web-devicons').setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
 -- same as `override` but specifically for operating system
 -- takes effect when `strict` is true
 override_by_operating_system = {
  ["apple"] = {
    icon = "",
    color = "#A2AAAD",
    cterm_color = "248",
    name = "Apple",
  },
 };
}

require('hop').setup{}


require('formatter').setup({
  filetype = {
    python = {
      -- Configuration for psf/black
      function()
        return {
          exe = "black", -- this should be available on your $PATH
          args = { '-' },
          stdin = true,
        }
      end
    }
  }
})


require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local octo_ok, octo = pcall(require, "octo")
if octo_ok then
  octo.setup({
    picker = "telescope",
    enable_builtin = true,
    mappings_disable_default = false,
    suppress_missing_scope = {
      projects_v2 = true,
    },
  })

  vim.treesitter.language.register("markdown", "octo")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "octo",
    callback = function(args)
      local opts = { buffer = args.buf, silent = true }
      vim.keymap.set("i", "@", "@<C-x><C-o>", opts)
      vim.keymap.set("i", "#", "#<C-x><C-o>", opts)
    end,
  })
end

-- require('Comment').setup()

local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
if gitsigns_ok then
  gitsigns.setup({
    signs = {
      add = { text = '▌' },
      change = { text = '▌' },
      delete = { text = '▁' },
      topdelete = { text = '▔' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '▌' },
      change = { text = '▌' },
      delete = { text = '▁' },
      topdelete = { text = '▔' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    on_attach = function(bufnr)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = bufnr,
          silent = true,
          desc = desc,
        })
      end

      local function visual_range()
        local start_line = vim.fn.line(".")
        local end_line = vim.fn.line("v")
        return { math.min(start_line, end_line), math.max(start_line, end_line) }
      end

      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
          return
        end

        gitsigns.nav_hunk("next")
      end, "Next Git Hunk")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
          return
        end

        gitsigns.nav_hunk("prev")
      end, "Previous Git Hunk")

      map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Git Hunk")
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk(visual_range())
      end, "Stage Selected Git Hunk")
      map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Git Hunk")
      map("n", "<leader>hu", gitsigns.reset_hunk, "Reset Git Hunk")
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, "Blame Git Line")
    end,
  })
end

-- dap
local dap = require('dap')
-- dap.adapters.python = {
--   type = 'executable';
--   command = '/.venv/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }
dap.adapters.python = {
  type = 'executable';
  command = '~/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

require('leap').add_default_mappings()

require("oil").setup()

-- require('copilot').setup({
--   panel = {
--     enabled = true,
--     auto_refresh = false,
--     keymap = {
--       jump_prev = "[[",
--       jump_next = "]]",
--       accept = "<CR>",
--       refresh = "gr",
--       open = "<M-CR>"
--     },
--     layout = {
--       position = "bottom", -- | top | left | right | horizontal | vertical
--       ratio = 0.4
--     },
--   },
--   suggestion = {
--     enabled = true,
--     auto_trigger = true,
--     hide_during_completion = true,
--     debounce = 75,
--     keymap = {
--       -- accept = "<M-l>",
--       accept = "<tab>",
--       accept_word = false,
--       accept_line = false,
--       next = "<M-]>",
--       prev = "<M-[>",
--       dismiss = "<C-]>",
--     },
--   },
--   filetypes = {
--     yaml = false,
--     markdown = false,
--     help = false,
--     gitcommit = false,
--     gitrebase = false,
--     hgcommit = false,
--     svn = false,
--     cvs = false,
--     -- ["."] = false,
--   },
--   copilot_node_command = 'node', -- Node.js version must be > 18.x
--   server_opts_overrides = {},
-- })

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
    agent = {
      adapter = "copilot",
    },
  },
})

require("CopilotChat").setup {
  -- See Configuration section for options
}

local agentic_ok, agentic = pcall(require, "agentic")
if agentic_ok then
  agentic.setup({
    provider = "codex-acp",
    windows = {
      position = "right",
      width = "40%",
      height = "30%",
    },
    diff_preview = {
      enabled = true,
      layout = "split",
      center_on_navigate_hunks = true,
    },
  })
end

-- =============================================================================
-- snacks.nvim setup (dependency for opencode.nvim)
-- =============================================================================
require('snacks').setup({
  input = {},
  picker = {},
  terminal = {},
})

-- =============================================================================
-- opencode.nvim setup
-- =============================================================================
---@type opencode.Opts
vim.g.opencode_opts = {
  provider = {
    enabled = "terminal",  -- Use Neovim built-in terminal
  },
}

-- Required for buffer auto-reload when opencode edits files
vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select opencode action" })
vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { expr = true, desc = "Add range to opencode" })
vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })

vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "opencode half page up" })
vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })

local diffview_ok, diffview = pcall(require, "diffview")
if diffview_ok then
  local actions_ok, actions = pcall(require, "diffview.actions")
  if actions_ok then
    diffview.setup({
      enhanced_diff_hl = true,
      use_icons = true,
      diffopt = {
        algorithm = "histogram",
        indent_heuristic = true,
      },
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        listing_style = "tree",
        win_config = {
          position = "left",
          width = 35,
        },
        always_show_sections = true,
        show_branch_name = true,
      },
      keymaps = {
        view = {
          { "n", "<leader>e", false },
          { "n", "<leader>b", false },
          { "n", "<leader>de", actions.focus_files, { desc = "Focus Diffview file panel" } },
          { "n", "<leader>db", actions.toggle_files, { desc = "Toggle Diffview file panel" } },
        },
        file_panel = {
          { "n", "<leader>e", false },
          { "n", "<leader>b", false },
          { "n", "<leader>de", actions.focus_files, { desc = "Focus Diffview file panel" } },
          { "n", "<leader>db", actions.toggle_files, { desc = "Toggle Diffview file panel" } },
        },
        file_history_panel = {
          { "n", "<leader>e", false },
          { "n", "<leader>b", false },
          { "n", "<leader>de", actions.focus_files, { desc = "Focus Diffview file panel" } },
          { "n", "<leader>db", actions.toggle_files, { desc = "Toggle Diffview file panel" } },
        },
      },
    })
  end
end

local difft_ok, difft = pcall(require, "difft")
if difft_ok then
  local function notify_difft(message, level)
    vim.notify("difft.nvim: " .. message, level or vim.log.levels.INFO)
  end

  local function current_file_context()
    local file_path = vim.api.nvim_buf_get_name(0)
    if file_path == "" then
      return nil, "Current buffer has no file path"
    end

    file_path = vim.fn.fnamemodify(file_path, ":p")

    local search_path = vim.fs.dirname(file_path)
    if not search_path or search_path == "" then
      return nil, "Could not determine the current file directory"
    end

    local git_dir = vim.fs.find(".git", { upward = true, path = search_path })[1]
    if not git_dir then
      return nil, "Current buffer is not inside a Git repository"
    end

    local root = vim.fs.dirname(git_dir)
    local relative_path = vim.fs.relpath(root, file_path)
    if not relative_path then
      return nil, "Could not determine the file path relative to the Git root"
    end

    return {
      file_path = file_path,
      root = root,
      relative_path = relative_path,
    }
  end

  local function build_difft_command(root, relative_path)
    local command = string.format(
      "GIT_EXTERNAL_DIFF=%s git -C %s diff --color=always --ext-diff",
      vim.fn.shellescape("/opt/homebrew/bin/difft --color=always"),
      vim.fn.shellescape(root)
    )

    if relative_path then
      command = command .. " -- " .. vim.fn.shellescape(relative_path)
    end

    return command
  end

  local function toggle_difft(cmd)
    if difft.exists() then
      difft.close()
      return
    end

    difft.diff({ cmd = cmd })
  end

  local function toggle_difft_repo()
    local context, err = current_file_context()
    if not context then
      notify_difft(err, vim.log.levels.WARN)
      return
    end

    toggle_difft(build_difft_command(context.root))
  end

  local function toggle_difft_file()
    local context, err = current_file_context()
    if not context then
      notify_difft(err, vim.log.levels.WARN)
      return
    end

    toggle_difft(build_difft_command(context.root, context.relative_path))
  end

  pcall(vim.api.nvim_del_user_command, "DifftRepo")
  pcall(vim.api.nvim_del_user_command, "DifftFile")

  vim.api.nvim_create_user_command("DifftRepo", toggle_difft_repo, {
    desc = "Toggle difft.nvim repo diff",
  })

  vim.api.nvim_create_user_command("DifftFile", toggle_difft_file, {
    desc = "Toggle difft.nvim file diff",
  })

  difft.setup({
    command = "GIT_EXTERNAL_DIFF='/opt/homebrew/bin/difft --color=always' git diff --color=always --ext-diff",
    layout = "ivy_taller",
    auto_jump = true,
    no_diff_message = "All clean! No changes detected.",
    loading_message = "Loading difftastic diff...",
    window = {
      number = false,
      relativenumber = false,
      border = "rounded",
    },
    header = {
      highlight = {
        link = "FloatTitle",
        full_width = true,
      },
    },
    diff = {
      highlights = {
        add = { link = "DiffAdd" },
        delete = { link = "DiffDelete" },
        change = { link = "DiffChange" },
        info = { link = "Directory" },
        hint = { link = "Special" },
        dim = { link = "Comment" },
      },
    },
  })
end

-- =============================================================================
-- codediff.nvim setup (VSCode-style diff view)
-- =============================================================================

require("codediff").setup({
  highlights = {
    line_insert = "DiffAdd",
    line_delete = "DiffDelete",
  },
  diff = {
    layout = "side-by-side", -- Diff layout: "side-by-side" or "inline"
    disable_inlay_hints = true,
    max_computation_time_ms = 5000,
    hide_merge_artifacts = false,
    original_position = "left",
    ignore_trim_whitespace = true,     -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
    conflict_result_position = "bottom", -- "bottom" (default): result below diff panes or "center": result between diff panes (three columns)
    conflict_result_height = 30,         -- Height of result pane in bottom layout (% of total height)
    conflict_result_width_ratio = { 1, 1, 1 }, -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
    compute_moves = false,              -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
  },
  explorer = {
    position = "left",
    width = 40,
    view_mode = "list",
  },
  keymaps = {
    view = {
      toggle_explorer = "<leader>dt",
    },
  },
})
