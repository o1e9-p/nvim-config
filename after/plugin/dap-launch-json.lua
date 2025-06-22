local function load_launch_json()
  local file_path = vim.fn.getcwd() .. "/.vscode/launch.json"
  local file = io.open(file_path, "r")

  if not file then
    print("launch.json not found in .vscode folder")
    return
  end

  local content = file:read("*a")
  file:close()

  local ok, parsed = pcall(vim.fn.json_decode, content)
  if not ok then
    print("Error parsing launch.json: " .. parsed)
    return
  end

  local configurations = parsed.configurations or {}
  for _, config in ipairs(configurations) do
    if config.type == "go" then
      require('dap').configurations.go = require('dap').configurations.go or {}
      table.insert(require('dap').configurations.go, {
        type = "go",
        name = config.name,
        request = config.request,
        mode = config.mode,
        program = config.program,
        env = config.env,
        args = config.args,
        dlvToolPath = config.dlvToolPath or "dlv",
        outputMode = "remote"
      })
    end
  end

  print("launch.json loaded successfully")
end

-- Автозагрузка конфигурации при старте
-- load_launch_json()

