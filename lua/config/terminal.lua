-- 终端配置
local M = {}

function M.setup()
  -- 设置终端颜色
  vim.api.nvim_set_hl(0, 'Terminal', { bg = '#1e1e2e', fg = '#cdd6f4' })

  -- 智能切换终端：<Space>t
  vim.keymap.set("n", "<Space>t", function()
    -- 检查是否已经有终端窗口
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
      if buftype == 'terminal' then
        -- 如果终端窗口存在，聚焦它
        vim.api.nvim_set_current_win(win)
        vim.cmd("startinsert")
        return
      end
    end
    
    -- 没有找到终端窗口，创建新的（底部水平分割）
    vim.cmd("below 10split | terminal")
    vim.cmd("startinsert")
    
    -- 设置这个终端窗口的特殊配置
    local term_buf = vim.api.nvim_get_current_buf()
    local term_win = vim.api.nvim_get_current_win()
    
    -- 只在终端buffer中设置q关闭
    vim.keymap.set("n", "q", function()
      vim.cmd("bd!")
    end, { buffer = term_buf, desc = "Close terminal" })
  end, { desc = "Toggle terminal (bottom)" })

  -- 垂直分割打开终端：<Space>tv
  vim.keymap.set("n", "<Space>tv", function()
    vim.cmd("vsplit | terminal")
    vim.cmd("startinsert")
  end, { desc = "Terminal vertical split" })

  -- 标签页打开终端：<Space>tt
  vim.keymap.set("n", "<Space>tt", function()
    vim.cmd("tabnew | terminal")
    vim.cmd("startinsert")
  end, { desc = "Terminal in new tab" })

  -- Rust 快捷键保持不变但优化显示
  vim.keymap.set("n", "<F5>", function()
    vim.cmd("below 10split | terminal cargo build")
    vim.cmd("startinsert")
  end, { desc = "Cargo Build" })
  
  vim.keymap.set("n", "<F6>", function()
    vim.cmd("below 10split | terminal cargo run")
    vim.cmd("startinsert")
  end, { desc = "Cargo Run" })
  
  vim.keymap.set("n", "<F7>", function()
    vim.cmd("below 10split | terminal cargo test")
    vim.cmd("startinsert")
  end, { desc = "Cargo Test" })

  -- 关键：终端模式下的 ESC 映射
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })
  
  -- 更好的方案：ESC 两次关闭终端
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:bd!<CR>", { desc = "Close terminal" })
  
  -- 终端窗口切换（在 terminal 模式也能用）
  vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
  vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
  vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
  vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
  
  -- 在 normal 模式也可以切换
  vim.keymap.set("n", "<C-h>", "<C-w>h")
  vim.keymap.set("n", "<C-j>", "<C-w>j")
  vim.keymap.set("n", "<C-k>", "<C-w>k")
  vim.keymap.set("n", "<C-l>", "<C-w>l")
  
  -- 自动命令：当打开终端时自动进入插入模式
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
      vim.cmd("startinsert")
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
    end
  })
  
  -- 自动命令：为终端 buffer 设置关闭快捷键
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function(args)
      local buf = args.buf
      -- 为这个终端 buffer 设置 q 关闭
      vim.keymap.set("n", "q", ":bd!<CR>", { buffer = buf, desc = "Close terminal" })
      vim.keymap.set("n", "<C-w>", ":bd!<CR>", { buffer = buf, desc = "Close terminal" })
    end
  })
end

return M
