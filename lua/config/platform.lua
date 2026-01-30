-- lua/config/platform.lua
local M = {}

M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
M.is_linux = vim.fn.has("unix") == 1
M.is_mac = vim.fn.has("mac") == 1

M.path_sep = M.is_windows and "\\" or "/"

-- 获取用户主目录
function M.get_home()
	if M.is_windows then
		return os.getenv("USERPROFILE")
	else
		return os.getenv("HOME")
	end
end

-- 路径连接辅助函数
function M.join_path(...)
	local parts = { ... }
	return table.concat(parts, M.path_sep)
end

return M
