return {
  {
    "mason-org/mason.nvim",
    opts = {
      -- 完全不自动安装任何工具，手动安装需要的
      ensure_installed = {},
      -- 或者只安装必要的
      -- ensure_installed = {"clangd", "cmake-language-server", "pyright"},
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {"clangd", "cmake", "pyright"},
    },
  },
}
