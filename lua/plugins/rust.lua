return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        -- 工具配置（包括 inlay hints）
        tools = {
          inlay_hints = {
            -- 自动显示内联提示
            auto = true,
            
            -- 只显示当前行的提示（可选）
            only_current_line = false,
            
            -- 提示样式
            show_parameter_hints = true,
            parameter_hints_prefix = "← ",
            other_hints_prefix = "⇒ ",
            
            -- 最大长度
            max_len_align = false,
            max_len_align_padding = 1,
            
            -- 高亮组
            highlight = "Comment",
          },
        },
        
        server = {
          standalone = true,
          on_attach = function(client, bufnr)
            local keymap_opts = { buffer = bufnr, noremap = true, silent = true }
            
            -- 查看定义
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
            
            -- 查看文档
            vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
            
            -- 切换内联提示的快捷键
            vim.keymap.set("n", "<leader>th", function()
              vim.cmd.RustLsp("inlayHints.toggle")
            end, { buffer = bufnr, desc = "切换内联提示" })
            
            -- 启用所有内联提示
            vim.keymap.set("n", "<leader>th", function()
              vim.cmd.RustLsp("inlayHints.enable")
            end, { buffer = bufnr, desc = "启用内联提示" })
            
            -- 禁用所有内联提示
            vim.keymap.set("n", "<leader>tH", function()
              vim.cmd.RustLsp("inlayHints.disable")
            end, { buffer = bufnr, desc = "禁用内联提示" })
          end,
          
          default_settings = {
            ["rust-analyzer"] = {
              -- 服务器端的 inlay hints 设置
              inlayHints = {
                enable = true,
                bindingModeHints = {
                  enable = true,
                },
                chainingHints = {
                  enable = true,
                },
                parameterHints = {
                  enable = true,
                },
                typeHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                lifetimeElisionHints = {
                  enable = "skip_trivial",
                  useParameterNames = true,
                },
                maxLength = 25,
                renderColons = true,
                showHiddenInlayHints = false,
              },
              
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      }
    end,
  },
}
