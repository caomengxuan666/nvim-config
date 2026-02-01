return {
	-- 新增：codelldb 调试配置（依赖 nvim-dap + dap-ui，保留原有 rustaceanvim 配置）
	{
		"mfussenegger/nvim-dap",
		ft = { "rust" },
		dependencies = {
			"simrat39/rust-tools.nvim",
			"rcarriga/nvim-dap-ui", -- 明确依赖 dap-ui，确保加载顺序正确
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui") -- 提前加载 dap-ui，放在配置外面

			-- 配置断点醒目标记（红色实心圆 + 暂停箭头，缩进规整）
			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "Error", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "🔴", texthl = "WarningMsg", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })

			-- 初始化 dap-ui（正确位置：在适配器配置前，不在 configurations 内部）
			dapui.setup()
			-- 调试会话生命周期联动 dap-ui（自动打开/关闭）
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- 配置 codelldb 适配器（指向你的 Mason 目录，路径正确）
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/adapter/codelldb"),
					args = { "--port", "${port}" },
				},
			}

			-- 配置 Rust 调试参数（正确数组格式，无嵌套错误）
			dap.configurations.rust = {
				{
					name = "Launch Rust Program",
					type = "codelldb",
					request = "launch",
					program = function()
						local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
						return vim.fn.getcwd() .. "/target/debug/" .. project_name
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = true,
					console = "externalTerminal",
					sourceLanguages = { "rust" },
					-- console = "internalConsole",  -- 禁用普通终端，强制内置调试控制台
				},
			}
		end,
	},

	-- 你的原有 rustaceanvim 配置（一字未改，缩进规整）
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
