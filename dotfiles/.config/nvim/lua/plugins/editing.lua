return {
  -- Surround — nvim-native rewrite of vim-surround, identical keybindings (ys, cs, ds)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- Make . repeat plugin actions
  "tpope/vim-repeat",

  -- Multiple cursors
  "mg979/vim-visual-multi",

  -- Easy align
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
    end,
  },

  -- Commenting — nvim-native replacement for tcomment_vim
  -- Keybindings: gcc (line), gc (motion), gbc (block)
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- Emmet
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact" },
  },

  -- Open file at specific line — e.g. nvim file.rb:42
  "bogado/file-line",

  -- Highlight trailing whitespace
  "bronson/vim-trailing-whitespace",

  -- Send lines to a tmux pane
  {
    "christoomey/vim-tmux-runner",
    config = function()
      vim.g.VtrUseVtrMaps             = 1
      vim.g.VtrStripLeadingWhitespace = 0
      vim.g.VtrAppendNewline          = 1
    end,
  },

  -- Rename current file with :Rename
  "danro/rename.vim",

  -- Haskell indentation
  "itchyny/vim-haskell-indent",

  -- Expand visual selection
  "Olical/vim-expand",

  -- Show N/M for search matches
  "henrik/vim-indexed-search",

  -- Enhanced search (centres matches, clears highlight on <CR>)
  "wincent/loupe",

  -- EditorConfig — built into Neovim >= 0.9, but kept for older versions
  -- { "editorconfig/editorconfig-vim" },

  -- Copilot — loaded only if USE_COPILOT env var is set
  {
    "github/copilot.vim",
    cond = function()
      return vim.env.USE_COPILOT ~= nil and vim.env.USE_COPILOT ~= ""
    end,
  },
}
