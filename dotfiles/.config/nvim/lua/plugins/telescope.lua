return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              -- Send results to quickfix, mirroring ctrl-q from fzf config
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-t>"] = actions.select_tab,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
            },
          },
        },
      })

      pcall(telescope.load_extension, "fzf")

      -- Keymaps — mirrors the fzf.vim mappings from the vim config
      local builtin = require("telescope.builtin")
      local map = vim.keymap.set

      map("n", "<c-p>",      builtin.find_files,                   { desc = "Find files" })
      map("n", "<leader>F",  builtin.live_grep,                    { desc = "Live grep (all files)" })
      map("n", "<leader>f",  builtin.current_buffer_fuzzy_find,    { desc = "Fuzzy find in buffer" })
      map("n", "<leader>b",  builtin.buffers,                      { desc = "Buffers" })
    end,
  },
}
