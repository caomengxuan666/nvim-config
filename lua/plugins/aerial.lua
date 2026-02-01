return {
  "stevearc/aerial.nvim",
  -- 新增：在 Rust/C/C++/Python 等文件打开时自动加载
  ft = { "rust", "c", "cpp", "python", "lua", "go" },
  cmd = { "AerialToggle", "AerialOpen", "AerialClose" },
  keys = {
    { "<leader>oo", "<cmd>AerialToggle right<CR>", desc = "Toggle Aerial Outline (Right)" },
    { "[s", "<cmd>AerialPrev<CR>", desc = "Jump to Previous Symbol" },
    { "]s", "<cmd>AerialNext<CR>", desc = "Jump to Next Symbol" },
  },
  opts = {
    placement = "right",
    width = 30,
    filter_kind = {
      "Class", "Constructor", "Enum", "Function", "Interface",
      "Method", "Module", "Namespace", "Property", "Struct", "Trait"
    },
    show_details = true,
    fold_level = 2,
    autojump = true,
    close_automatic = false,
    highlight_on_hover = true,
    disable_mouse = false,
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
  },
}
