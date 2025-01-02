local dap = require('dap')
local dap_go = require('dap-go')

dap_go.setup()

-- Настройка для отображения UI (опционально)
local dapui = require("dapui")
dapui.setup()

-- Автоматическое открытие UI при запуске/завершении сессии
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.api.nvim_set_keymap('n', '<F5>', ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ":lua require'dap'.run_last()<CR>", { noremap = true, silent = true })

vim.fn.sign_define('DapBreakpoint', {text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped', {text = '▶', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected', {text = '✗', texthl = 'DapBreakpointRejected', linehl = '', numhl = ''})

vim.cmd [[
  highlight DapBreakpoint guifg=#FF5555 gui=bold
  highlight DapStopped guifg=#00FF00 gui=bold
  highlight DapBreakpointRejected guifg=#FF0000 gui=italic
  highlight DapStoppedLine guibg=#1E1E1E
]]
