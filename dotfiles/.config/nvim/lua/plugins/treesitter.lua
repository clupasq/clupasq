return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      -- Textobjects — replaces vim-angry (argument text objects)
      --               and the coc funcobj/classobj mappings
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "javascript", "typescript", "tsx",
        "python", "lua",
        "json", "yaml", "toml",
        "html", "css",
        "bash", "vim", "vimdoc",
        "markdown", "markdown_inline",
        "haskell",
      },
      auto_install = true,
      highlight = { enable = true },
      indent    = { enable = true },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
            ["ic"] = "@class.inner",
            ["ac"] = "@class.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start     = { ["]m"] = "@function.outer" },
          goto_previous_start = { ["[m"] = "@function.outer" },
        },
      },
    },
  },
}
