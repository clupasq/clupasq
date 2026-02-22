return {
  -- Colorscheme
  {
    "nanotech/jellybeans.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("jellybeans")
      -- Transparent background, same as vim config
      vim.cmd([[
        hi Normal    guibg=NONE ctermbg=NONE
        hi NonText   guibg=NONE ctermbg=NONE
      ]])
    end,
  },

  -- Extra colorschemes (lazy loaded, browse with :colorscheme <Tab>)
  { "flazz/vim-colorschemes", lazy = true },

  -- Statusline — replaces vim-airline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "jellybeans",
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },  -- show relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Distraction-free writing — replaces goyo.vim
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
  },
}
