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
    -- modified from: ~/.local/share/nvim/lazy/NvChad/lua/nvchad
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
      -- from nvchad
      require("nvim-autopairs").setup(opts)

      -- custom start
      local autopairs = require "nvim-autopairs"
      local rule = require "nvim-autopairs.rule"

      autopairs.add_rules {
        rule("\\(", "\\)", "tex"),
        rule("$", "$", { "tex", "markdown", "typst" }),
        rule("\\[", "\\]", "tex"),
        rule("\\{", "\\}", "tex"),
      }
      -- custom end

      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("configs.quarto")
    end,
  },

  {
    "hkupty/iron.nvim",
    lazy = false,
    config = function()
      require("configs.iron")
    end
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "tinymist"
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
