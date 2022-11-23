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
  require('keybindings').map_lsp_on_attach(client, bufnr)
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

  -- rust
  ["rust_analyzer"] = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(client, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
          require('keybindings').map_lsp_on_attach(client, bufnr)
        end,
      },
    })
  end,

  -- lua
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
