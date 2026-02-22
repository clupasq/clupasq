local opt = vim.opt

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.ruler = true
opt.showmode = true
opt.showcmd = true
opt.laststatus = 2
opt.title = true
opt.visualbell = true
opt.fillchars = { vert = "┃" }
opt.list = true
opt.listchars = { trail = "·", tab = "»·" }
opt.showbreak = "╰ "
opt.scrolloff = 3
opt.sidescrolloff = 3
opt.wrap = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Editing
opt.backspace = { "indent", "eol", "start" }
opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true

-- Behaviour
opt.hidden = true
opt.wildmenu = true
opt.wildmode = "list:longest"
opt.mouse = "a"
opt.splitright = true
opt.splitbelow = true
opt.lazyredraw = true
opt.updatetime = 300
opt.signcolumn = "yes"

-- Folding
opt.foldmethod = "indent"
opt.foldlevelstart = 20

-- Short messages
opt.shortmess:append("A")  -- ignore annoying swapfile messages
opt.shortmess:append("I")  -- no splash screen
opt.shortmess:append("O")  -- file-read message overwrites previous
opt.shortmess:append("T")  -- truncate non-file messages in middle
opt.shortmess:append("W")  -- don't echo "[w]"/"[written]" when writing
opt.shortmess:append("a")  -- use abbreviations in messages
opt.shortmess:append("o")  -- overwrite file-written messages
opt.shortmess:append("t")  -- truncate file messages at start

-- Backup / swap / undo
-- Neovim uses ~/.local/share/nvim by default, kept separate from Vim's ~/.vim/tmp
local function is_sudo()
  return os.getenv("SUDO_USER") ~= nil
end

local function ensure_dir(path)
  local expanded = vim.fn.expand(path)
  if vim.fn.isdirectory(expanded) == 0 then
    vim.fn.mkdir(expanded, "p")
  end
end

if is_sudo() then
  opt.backup = false
  opt.writebackup = false
  opt.swapfile = false
  opt.undofile = false
else
  ensure_dir("~/.local/share/nvim/backup")
  ensure_dir("~/.local/share/nvim/swap")
  ensure_dir("~/.local/share/nvim/undo")

  opt.backupdir = { vim.fn.expand("~/.local/share/nvim/backup"), "." }
  opt.directory = { vim.fn.expand("~/.local/share/nvim/swap//"), "." }
  opt.undodir   = { vim.fn.expand("~/.local/share/nvim/undo"), "." }
  opt.undofile  = true
end

-- Netrw
vim.g.netrw_liststyle = 3
