return {
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
}
