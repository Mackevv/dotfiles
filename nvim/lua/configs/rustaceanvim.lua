local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
}

-- Toggle keymap for rust-analyzer diagnosis
local inlay_hints_enabled = true
local diagnostics_virtual_text_enabled = true

local function toggle_inlay_hints()
  inlay_hints_enabled = not inlay_hints_enabled and true or false
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].filetype == "rust" and vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(bufnr, inlay_hints_enabled)
    end
  end
  vim.notify("Inlay hints " .. (inlay_hints_enabled and "enabled" or "disabled"))
end

local function toggle_virtual_text()
  diagnostics_virtual_text_enabled = not diagnostics_virtual_text_enabled
  vim.diagnostic.config({
    virtual_text = diagnostics_virtual_text_enabled,
  })
  vim.notify("Virtual text diagnostics " .. (diagnostics_virtual_text_enabled and "enabled" or "disabled"))
end

local function toggle_rust_noise()
  toggle_inlay_hints()
  toggle_virtual_text()
end

vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      -- Keymaps scoped to Rust buffers
      local opts = { buffer = bufnr, desc = "" }

      vim.keymap.set("n", "<leader>ti", toggle_inlay_hints,
        vim.tbl_extend("force", opts, { desc = "Toggle Inlay Hints" }))
      vim.keymap.set("n", "<leader>td", toggle_virtual_text,
        vim.tbl_extend("force", opts, { desc = "Toggle Virtual Text Diagnostics" }))
      vim.keymap.set("n", "<leader>tt", toggle_rust_noise,
        vim.tbl_extend("force", opts, { desc = "Toggle Rust Visual Noise" }))
    end,
  },
}
