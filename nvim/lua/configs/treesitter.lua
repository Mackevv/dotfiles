local options = {
  ensure_installed = {
    "bash",
    "fish",
    "lua",
    "luadoc",
    "markdown",
    "printf",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
    "rust"
  },

  highlight = {
    enable = true,
    use_languagetree = true
  },

  ident = {
    enable = true
  }
}

require("nvim-treesitter.configs").setup(options)
