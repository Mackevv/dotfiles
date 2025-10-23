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
    default_method = "slime",   -- "molten", "slime", "iron" or <function>
    ft_runners = {},            -- filetype to runner, ie. `{ python = "molten" }`.
    -- takes precedence over `default_method`
    never_run = { "yaml" },     -- filetypes which are never sent to a code runner
  },
})
