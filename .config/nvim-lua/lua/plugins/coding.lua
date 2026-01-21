return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
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
      "Kaiser-Yang/blink-cmp-avante",
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
        default = { "path", "avante", "lsp", "snippets", "buffer" },
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
          avante = {
            name = "Avante",
            module = "blink-cmp-avante",
          }
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
    "nvim-mini/mini.pairs",
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
      -- Close the overseer.nvim window if it is the last one remaining
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local current_tabpage = vim.api.nvim_get_current_tabpage()
          local wins = vim.api.nvim_tabpage_list_wins(current_tabpage)
          ---@param winid integer
          ---@return boolean
          local function is_overseer_window(winid)
            local bufnr = vim.api.nvim_win_get_buf(winid)
            if vim.bo[bufnr].filetype == "OverseerList" then
              return true
            elseif vim.b[bufnr].overseer_task then
              return true
            end
            return false
          end
          local overseer_wins = vim.tbl_filter(is_overseer_window, wins)
          if (#wins - #overseer_wins) == 1 then
            vim.tbl_map(
              function(winid) vim.api.nvim_win_close(winid, false) end,
              overseer_wins
            )
          end
        end,
      })
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
      {
        "ravitemer/mcphub.nvim",
        build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
        opts = {
          auto_approve = true,
          extensions = {
            avante = {
              make_slash_commands = true,
            }
          }
        }
      }
    },
    event = "VeryLazy",
    opts = {
      mode = "legacy",
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      disabled_tools = {
        "list_files", -- Built-in file operations
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash", -- Built-in terminal access
        "python",
      },
      instructions_file = "avante.md",
      provider = "ollama",
      auto_suggestions_provider = "ollama",
      providers = {
        ollama = {
          model = "gpt-oss-32k",
          is_env_set = function() return true end,
          extra_request_body = {
            max_tokens = 65535,
          }
        },
      },
    },
  },
  {
    {

      "ysmb-wtsg/in-and-out.nvim",
      lazy = false,
      event = { "InsertEnter", "CmdLineEnter" },
      priority = 1000,
      keys = {
        {
          "<M-l>",
          function() require("in-and-out").in_and_out() end,
          mode = "i",
          desc = "in-and-out",
        },
      },
    }
  },
}
