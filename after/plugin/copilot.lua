local copilot_chat = require("CopilotChat")

copilot_chat.setup({
  model = "claude-sonnet-4",
  debug = false,
  show_help = true,
  prompts = {
    Explain = "Объясни, как работает этот код.",
    Review = "Проанализируй следующий код и предложи улучшения.",
    Tests = "Создай юнит-тесты для следующего кода.",
    Refactor = "Рефакторинг кода для улучшения читаемости."
  },
  window = {
    layout = "vertical",
    relative = "editor",
    width = 0.4,
    border = "single"
  },
  auto_follow_cursor = false,
})

vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Открыть Copilot Chat" })
vim.keymap.set("v", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Объяснить код" })
vim.keymap.set("v", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "Рецензировать код" })
vim.keymap.set("v", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "Сгенерировать тесты" })
vim.keymap.set("v", "<leader>cf", "<cmd>CopilotChatRefactor<cr>", { desc = "Рефакторинг кода" })
vim.keymap.set("v", "<leader>ci", "<cmd>CopilotChatFix<cr>", { desc = "Исправить проблемы в коде" })
vim.keymap.set("v", "<leader>co", "<cmd>CopilotChatOptimize<cr>", { desc = "Оптимизировать код" })
vim.keymap.set("n", "<leader>cm", "<cmd>CopilotChatCommit<cr>", { desc = "Создать сообщение коммита" })
vim.keymap.set("n", "<leader>cx", "<cmd>CopilotChatReset<cr>", { desc = "Сбросить чат" })
vim.keymap.set("n", "<leader>cp", "<cmd>CopilotChatPrompts<cr>", { desc = "Выбрать шаблон запроса" })
vim.keymap.set("n", "<leader>cq", function()
  local input = vim.fn.input("Быстрый запрос: ")
    if input ~= "" then
      local ok, err = pcall(function() require("CopilotChat").ask(input) end)
      if not ok then
        vim.notify("Ошибка Copilot: " .. tostring(err), vim.log.levels.ERROR)
      end
    end
  end, {desc = "Быстрый запрос" })


