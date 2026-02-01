return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      -- 启用 aerial.nvim 主题美化
      aerial = true,
      -- 其他常用集成（保留你的现有配置，没有的话可自行添加）
      treesitter = true,
      lsp = true,
      mason = true,
      which_key = true,
    },
  },
}
