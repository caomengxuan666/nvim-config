-- lua/config/smart.lua
local M = {}

-- 检测平台
M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
M.is_linux = vim.fn.has("unix") == 1 and not M.is_windows

-- 获取CPU核心数（针对Linux优化）
function M.get_cpu_cores()
	if M.is_windows then
		local handle = io.popen("echo %NUMBER_OF_PROCESSORS%")
		local result = handle:read("*a")
		handle:close()
		return tonumber(result) or 2
	else
		-- Linux: 使用更轻量的检测
		local cores = 2 -- 默认值
		local cpuinfo = vim.fn.system("grep -c ^processor /proc/cpuinfo 2>/dev/null")
		if cpuinfo ~= "" then
			cores = tonumber(cpuinfo) or 2
		end
		return math.max(cores, 1)
	end
end

M.cpu_cores = M.get_cpu_cores()
M.jobs = math.max(math.floor(M.cpu_cores * 0.75), 1)

print(
	string.format(
		"💡 系统信息: %s, %d核心, 并发数: %d",
		M.is_windows and "Windows" or "Linux",
		M.cpu_cores,
		M.jobs
	)
)

return M
