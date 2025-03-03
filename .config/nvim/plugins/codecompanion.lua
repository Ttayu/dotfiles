require('codecompanion').setup({
  adapters = {
    ollama = function()
      return require('codecompanion.adapters').extend('ollama', {
        schema = {
          model = {
            default = 'phi4',
            choices = {
              'phi4',
              'deepseek-r1:14b',
              'futuretea/deepseek-r1-cline:14b',
            },
          },
        },
      })
    end,
  },
  strategies = {
    chat = { adapter = "ollama", },
    inline = { adapter = "ollama", },
    agent = { adapter = "ollama", },
  },
})

vim.cmd('cabbrev cci CodeCompanion')
vim.cmd('cabbrev ccc CodeCompanionChat')
vim.cmd('cabbrev cca CodeCompanionActions')
