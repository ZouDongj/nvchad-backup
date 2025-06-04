-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "html", "cssls", "ts_ls", "clangd", "pyright", "bashls", "lemminx", "cmake" }

local my_on_attach = function(_, bufnr)
  on_attach(_, bufnr)
  -- 设置诊断信息的显示样式
  local x = vim.diagnostic.severity
  vim.diagnostic.config({
    virtual_text = false,
    signs = { text = { [x.ERROR] = "󰅚 ", [x.WARN] = "󰀪 ", [x.HINT] = "󰌶 ", [x.INFO] = " " } },
    underline = true,
    update_in_insert = false,
  })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = my_on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

lspconfig["lua_ls"].setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- 添加 vim 作为全局变量
      },
    },
  },
  on_attach = my_on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

-- -- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
