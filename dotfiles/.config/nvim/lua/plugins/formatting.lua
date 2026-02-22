return {
  -- Formatting — replaces vim-prettier
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd   = "ConformInfo",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript      = { "prettier" },
          javascriptreact = { "prettier" },
          typescript      = { "prettier" },
          typescriptreact = { "prettier" },
          json            = { "prettier" },
          html            = { "prettier" },
          css             = { "prettier" },
          python          = { "black" },
          lua             = { "stylua" },
        },
        format_on_save = {
          timeout_ms   = 500,
          lsp_fallback = true,
        },
      })

      -- :Format command — mirrors the one from the coc config
      vim.api.nvim_create_user_command("Format", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, {})
    end,
  },

  -- Linting — replaces ALE
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript      = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python          = { "ruff" },
      }

      -- Only run linters if a config file exists in the project
      local function config_exists(files)
        return vim.fn.findfile(table.concat(files, ","), ".;") ~= ""
      end

      local eslint_configs = {
        ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
        ".eslintrc.yaml", ".eslintrc.yml", "eslint.config.js",
        "eslint.config.mjs", "eslint.config.cjs",
      }
      local ruff_configs = {
        "pyproject.toml", "ruff.toml", ".ruff.toml",
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          local ft = vim.bo.filetype
          if ft == "javascript" or ft == "javascriptreact" or
             ft == "typescript" or ft == "typescriptreact" then
            if config_exists(eslint_configs) then lint.try_lint() end
          elseif ft == "python" then
            if config_exists(ruff_configs) then lint.try_lint() end
          else
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
