-- Rust 快捷键 (F5-F7) → 使用普通 terminal buffer，但自动关闭
vim.keymap.set("n", "<F5>", ":terminal cargo build<CR>", { desc = "Cargo Build" })
vim.keymap.set("n", "<F6>", ":terminal cargo run<CR>", { desc = "Cargo Run" })
vim.keymap.set("n", "<F7>", ":terminal cargo test<CR>", { desc = "Cargo Test" })

-- <Space>t：在底部打开水平终端
vim.keymap.set("n", "<Space>t", function()
	vim.cmd("below split | terminal")
	vim.cmd("startinsert")
end, { desc = "Toggle Terminal (bottom)" })

-- 快速退出系列（添加到文件末尾）
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>qw", ":wqa<CR>", { desc = "Save all and quit" })
vim.keymap.set("n", "<leader>qf", ":qa!<CR>", { desc = "Force quit all" })

-- 简单直接的退出快捷键（英文界面，清晰）
vim.keymap.set("n", "<leader>qq", function()
	local modified_count = 0
	for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if buf.changed == 1 then
			modified_count = modified_count + 1
		end
	end

	if modified_count == 0 then
		vim.cmd("qa")
	else
		-- 用英文显示，避免混乱
		print(modified_count .. " files have unsaved changes.")
		print("1: Save all and quit")
		print("2: Quit without saving")
		print("3: Cancel")

		local input = vim.fn.input("Choose [1/2/3]: ")

		if input == "1" then
			vim.cmd("xa")
		elseif input == "2" then
			vim.cmd("qa!")
		end
	end
end, { desc = "Smart quit with English prompt" })
-- ========== 自定义 Buffer 切换快捷键（原生，无插件依赖） ==========
vim.keymap.set('n', '<leader>l', ':bnext<CR>', { desc = "Buffer: 切换到下一个" })
vim.keymap.set('n', '<leader>h', ':bprevious<CR>', { desc = "Buffer: 切换到上一个" })
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { desc = "Buffer: 关闭当前" })
vim.keymap.set('n', '<leader>1', ':b 1<CR>', { desc = "Buffer: 跳转到第 1 个" })
vim.keymap.set('n', '<leader>2', ':b 2<CR>', { desc = "Buffer: 跳转到第 2 个" })
vim.keymap.set('n', '<leader>3', ':b 3<CR>', { desc = "Buffer: 跳转到第 3 个" })

-- ========== Rust 项目格式化：空格+L+F 快捷键 ==========
vim.keymap.set('n', '<leader>lf', '<cmd>!cargo fmt<CR>', { desc = "Rust: 格式化整个项目（cargo fmt）" })
