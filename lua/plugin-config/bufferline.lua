local status, bufferline = pcall(require, "bufferline")
if not status then
    vim.notify("bufferline not found")
  return
end

-- bufferline config
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    -- close tab -- moll/vim-bbye -- :Bdelete --
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-tree的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
  -- 使用nvim 内置LSP
  diagnostics = "nvim_lsp",
  -- 可选，显示 LSP 报错图标
  ---@diagnostic disable-next-line: unused-local
  diagnostics_indicator = function(count, level, diagnostics_dict, context)
    local s = " "
    for e, n in pairs(diagnostics_dict) do
      local sym = e == "error" and " " or (e == "warning" and " " or "")
      s = s .. n .. sym
    end
    return s
  end,
  },
})
