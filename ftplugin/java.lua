local mason_path = vim.fn.stdpath("data") .. "/mason/"

local config = {
  cmd = {
    vim.fn.expand(mason_path .. "packages/jdtls/jdtls"),
    "--jvm-arg=-javaagent:" .. vim.fn.expand(mason_path .. "packages/jdtls/lombok.jar"),
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
