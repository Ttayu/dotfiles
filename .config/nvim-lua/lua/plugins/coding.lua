return {
  {
    "folke/lazydev.nvim",
    event = "VeryLazy",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "saghen/blink.compat", opts = {} },
      "dmitmel/cmp-cmdline-history",
    },
    event = { "InsertEnter", "CmdLineEnter" },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'enter',
        ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-b>'] = { 'fallback' },
      },
      cmdline = {
        keymap = {
          ['<CR>'] = { 'accept', 'fallback' },
          ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
          ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
          ['<C-b>'] = { 'fallback' },
        },
        sources = {
          "buffer", "cmdline", "cmdline_history", "path",
        },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },
      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        trigger = { show_on_blocked_trigger_characters = { ' ', '\n', '\t', ':' } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        list = {
          selection = { preselect = false, auto_insert = true },
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "path", "lsp", "snippets", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end
            }
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          cmdline_history = {
            name = "cmdline_history",
            module = 'blink.compat.source',
            score_offset = -3,
          },
        },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      -- Duplicate completions: https://github.com/Saghen/blink.cmp/issues/1222
      local original = require("blink.cmp.completion.list").show
      ---@diagnostic disable-next-line: duplicate-set-field
      require("blink.cmp.completion.list").show = function(ctx, items_by_source)
        local seen = {}
        local function filter(item)
          if seen[item.label] then return false end
          seen[item.label] = true
          return true
        end
        for id in vim.iter(opts.sources.default) do
          items_by_source[id] = items_by_source[id] and vim.iter(items_by_source[id]):filter(filter):totable()
        end
        return original(ctx, items_by_source)
      end
      require("blink.cmp").setup(opts)
    end
  },
  {
    "echasnovski/mini.pairs",
    event = { "InsertEnter", "CmdLineEnter" },
    config = true,
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      task_list = {
        min_height = 12,
      }
    },
    keys = {
      { "<C-q>",    "<CMD>OverseerRun<CR>",    desc = "Overseer Run" },
      { "<Space>r", "<CMD>OverseerRun<CR>",    desc = "Overseer Run" },
      { "<Space>R", "<CMD>OverseerToggle<CR>", desc = "Toggle Task List" },
    },
    config = function(_, opts)
      local overseer = require("overseer")

      overseer.register_template({
        name = "Run current file with uv",
        builder = function()
          local file = vim.api.nvim_buf_get_name(0)
          return {
            cmd = { "uv", "run", file },
            name = "uv run " .. vim.fn.fnamemodify(file, ":t"),
            components = {
              "open_output",
              "default",
            },
          }
        end,
        condition = {
          filetype = { "python" },
        },
      })

      require("overseer").setup(opts)
    end
  },
  {
    "yetone/avante.nvim",
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim", -- for input provider snacks
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    event = "VeryLazy",
    opts = {
      auto_suggestions_provider = "ollama",
      cursor_applying_provider = "ollama",
      memory_summary_provider = "ollama",
      provider = "ollama",
      providers = {
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "devstral:latest"
        }
      },
      behaviour = {
        enable_cursor_planning_mode = false,
      },
    },
  },
}
