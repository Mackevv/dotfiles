-- Track toggle states
local inlay_hints_enabled = true
local diagnostics_virtual_text_enabled = true

-- Toggle inlay hints
local function toggle_inlay_hints()
  inlay_hints_enabled = not inlay_hints_enabled
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(bufnr, inlay_hints_enabled)
    end
  end
  vim.notify("Inlay hints " .. (inlay_hints_enabled and "enabled" or "disabled"))
end

return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufWritePre", "BufNewFile" },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.treesitter"
    end
  },

  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      local quarto = require("quarto")

      quarto.setup({
        debug = false,
        closepreviewonexit = true,
        lspfeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "bufwritepost" },
          },
          completion = {
            enabled = true,
          },
        },
        coderunner = {
          enabled = true,
          default_method = "slime", -- "molten", "slime", "iron" or <function>
          ft_runners = {},          -- filetype to runner, ie. `{ python = "molten" }`.
          -- takes precedence over `default_method`
          never_run = { "yaml" },   -- filetypes which are never sent to a code runner
        },
      })
    end,
  },

  {
    "hkupty/iron.nvim",
    lazy = false,
    config = function()
      local iron = require("iron.core")

      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").bottom(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
      vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
      vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
      vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },

  -- Rust ----
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "configs.rustaceanvim"
    end
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" } }
      })
    end
  },
}
