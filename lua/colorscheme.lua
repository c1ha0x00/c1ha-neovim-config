local colorscheme = "tokyonight"
-- "tender"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " NOT FOUND nya!")
  return
end
