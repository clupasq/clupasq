return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Installs and manages language servers
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- Auto-installs all tools (formatters, linters, LSP servers)
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {
            -- Language servers
            "ts_ls",
            "pyright",
            "lua_ls",
            -- Formatters
            "prettier",
            "black",
            "stylua",
            -- Linters
            "eslint_d",
            "ruff",
          },
          auto_update = false,
          run_on_start = true,
        },
      },
      -- LSP status indicator in the corner
      { "j-hui/fidget.nvim", opts = {} },
      -- Better lua_ls config for editing neovim configs
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- Keymaps applied to every buffer that has an LSP attached.
      -- Mirrors the coc.nvim keymaps from the old vim config.
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        -- GoTo navigation
        map("n", "gd",         vim.lsp.buf.definition,                          "Go to definition")
        map("n", "gy",         vim.lsp.buf.type_definition,                     "Go to type definition")
        map("n", "gi",         vim.lsp.buf.implementation,                      "Go to implementation")
        map("n", "gr",         require("telescope.builtin").lsp_references,     "Go to references")

        -- Hover docs
        map("n", "K",          vim.lsp.buf.hover,                               "Hover documentation")

        -- Diagnostics — mirrors [g / ]g from coc
        map("n", "[g",         vim.diagnostic.goto_prev,                        "Previous diagnostic")
        map("n", "]g",         vim.diagnostic.goto_next,                        "Next diagnostic")

        -- Actions — mirrors coc mappings
        map("n",        "<leader>rn", vim.lsp.buf.rename,                       "Rename symbol")
        map({ "n","x"}, "<leader>x",  vim.lsp.buf.code_action,                  "Code action")
        map("n",        "<leader>qf", vim.lsp.buf.code_action,                  "Quick fix")

        -- Lists — mirrors <space>d / <space>o / <space>s from coc
        map("n", "<space>d",   "<cmd>Telescope diagnostics<cr>",                "Diagnostics list")
        map("n", "<space>o",   "<cmd>Telescope lsp_document_symbols<cr>",       "Document symbols")
        map("n", "<space>s",   "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols")

        -- Organise imports
        map("n", "<leader>or", function()
          vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
        end, "Organise imports")
      end

      -- Extend capabilities with nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Language servers to install and configure via mason
      local servers = {
        ts_ls   = {},
        pyright = {},
        lua_ls  = {
          settings = {
            Lua = {
              workspace  = { checkThirdParty = false },
              telemetry  = { enable = false },
            },
          },
        },
      }

      require("mason-lspconfig").setup({
        ensure_installed       = vim.tbl_keys(servers),
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              on_attach    = on_attach,
              settings     = (servers[server_name] or {}).settings,
            })
          end,
        },
      })

      -- Diagnostic display config
      vim.diagnostic.config({
        virtual_text   = true,
        signs          = true,
        underline      = true,
        update_in_insert = false,
        severity_sort  = true,
      })
    end,
  },

  -- Completion — replaces coc's built-in completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          -- Load VSCode-style snippets (replaces vim-snippets + honza)
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      local function check_backspace()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
      end

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Mirrors coc: <C-space> triggers completion
          ["<C-space>"] = cmp.mapping.complete(),
          -- Mirrors coc: <CR> confirms selection
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          -- Mirrors coc: <Tab> confirms or expands/jumps snippet
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- Scroll docs in popup — mirrors <C-f>/<C-b> coc scroll
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
