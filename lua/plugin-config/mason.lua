-- 查找mason插件，未找到就停止执行
local status, mason= pcall(require, "mason")
if not status then
    vim.notify("没有找到 mason")
  return
end

local status, mason_lspconfig= pcall(require, "mason-lspconfig")
if not status then
    vim.notify("没有找到 mason-lspconfig")
  return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
    vim.notify("没有找到 lspconfig")
  return
end

mason.setup{
    ui = {
        icons = {
            package_installed = "✓",
            package_pending   = "➜",
            package_uninstalled = "✗",
        }
    }
}

mason_lspconfig.setup {
     ensure_installed = { "sumneko_lua", "rust_analyzer" },
}

mason_lspconfig.setup_handlers({
    function (server_name)
        require("lspconfig")[server_name].setup {
        }
    end
})

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}
