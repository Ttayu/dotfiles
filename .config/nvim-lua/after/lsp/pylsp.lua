return {
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        flake8 = { enabled = false },
        autopep8 = { enabled = false },
        pyls_flake8 = { enabled = false },
        pylsp_black = { enabled = false },
        pyls_isort = { enabled = false },
        yapf = { enabled = false },
        pylsp_mypy = {
          enabled = true,
          overrides = {
            true,
            "--ignore-missing-imports",
            "--no-site-packages",
            "--allow-untyped-calls",
            "--allow-untyped-decorators",
            "--allow-untyped-defs",
          },
          live_mode = false,
        },
        ruff = { enabled = false },
      },
    },
  },
  before_init = function(_, config)
    local venv_path = vim.fs.joinpath(config.root_dir, "/.venv")
    if vim.fn.isdirectory(venv_path) == 1 then
      vim.env.VIRTUAL_ENV = venv_path
      vim.env.PATH = vim.fs.joinpath(venv_path, "/bin:", vim.env.PATH)
    end
    local python_executable = vim.fs.joinpath(venv_path, "/bin/python")
    config.settings.pylsp.plugins.jedi = {}
    config.settings.pylsp.plugins.jedi.environment = python_executable

    local pdm_packages = vim.fs.joinpath(config.root_dir, "__pypackages__")

    local python_version = vim.fn.trim(vim.fn.system("python -V"))
    local major_minor_version = string.match(python_version, "Python (%d+%.%d+)")
    local python_packages = vim.fs.joinpath(pdm_packages, major_minor_version, "lib")

    local src_path = vim.fs.joinpath(config.root_dir, "src")
    config.settings.pylsp.plugins.jedi.extra_paths = { python_packages, src_path }
  end,
}
