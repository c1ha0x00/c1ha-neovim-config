-- 查找mason插件，未找到就停止执行
local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end

local status01, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status01 then
  vim.notify("没有找到 mason-lspconfig")
  return
end

local status02, lspconfig = pcall(require, "lspconfig")
if not status02 then
  vim.notify("没有找到 lspconfig")
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed   = "✓",
      package_pending     = "➜",
      package_uninstalled = "✗",
    }
  }
})

mason_lspconfig.setup({
  ensure_installed = {
    "sumneko_lua",
    "rust_analyzer",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "tsserver",
    "bashls",
    "dockerls",
  },
})


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      flags = lsp_flags,
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.
  --["rust_analyzer"] = function ()
  -- require("rust-tools").setup {}
  --end,
  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup {
      on_attach = on_attach,
      flags = lsp_flags,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
})
