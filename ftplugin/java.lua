local config = {
  cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  init_options = {
    settings = {
      java = {
        implementationsCodeLens = { enabled = true },
        imports = { -- <- this
          gradle = {
            enabled = true,
            wrapper = {
              enabled = true,
              checksums = {
                {
                  sha256 = '7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172',
                  allowed = true
                }
              },
            }
          }
        },
      },
    }
  }
}







require('jdtls').start_or_attach(config)
