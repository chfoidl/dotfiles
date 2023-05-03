local ok, dap = pcall(require, "dap")
if not ok then
  return
end

dap.set_log_level('TRACE')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/chfoidl/workspace/private/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
  {
    type = 'php',
    request = "launch",
    hostname = "0.0.0.0",
    port = 9003,
    pathMappings = {
      ['/var/www/html'] = '${workspaceFolder}',
    },
    auto_continue_if_many_stopped = false
  },
}
