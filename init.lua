-- 基础配置
require("basic")

-- Packer 插件管理
require("plugins")

-- 主题设置
require("colorscheme")

-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.nvim-treesitter")
require("plugin-config.telescope")
require("plugin-config.dashboard")
require("plugin-config.project")
require("plugin-config.nvim-transparent")

-- 快捷键映射
require("keybindings")

-- lsp & mason 
require("plugin-config.lsp.mason")

-- cmp
require("plugin-config.cmp")

-- neovide
require("neovide")
