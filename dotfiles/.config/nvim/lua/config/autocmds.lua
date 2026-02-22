local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank — built-in Neovim, replaces vim-highlightedyank plugin
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Filetype overrides
augroup("FiletypeOverrides", { clear = true })
autocmd("FileType", {
  group = "FiletypeOverrides",
  pattern = { "typescript", "php" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Extension → filetype mappings
augroup("FiletypeMappings", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = "FiletypeMappings",
  pattern = { "*.osm", "*.osc" },
  command = "set filetype=xml",
})
autocmd({ "BufNewFile", "BufRead" }, {
  group = "FiletypeMappings",
  pattern = "*.geojson",
  command = "set filetype=json",
})
autocmd({ "BufNewFile", "BufRead" }, {
  group = "FiletypeMappings",
  pattern = "Jenkinsfile",
  command = "set syntax=groovy",
})

-- Load local vimrc if present
if vim.fn.filereadable(".vimrc.local") == 1 then
  vim.cmd("source .vimrc.local")
end
