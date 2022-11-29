local status, transparent = pcall(require, "transparent")
if not status then
    vim.notify("nvim-transparent not found nya~~~")
  return
end

transparent.setup({
  enable = true,
  extra_groups = {
    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude = {},
})
