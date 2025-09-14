vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2 -- 2 spaces for indent
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- Search settings
opt.ignorecase = rue -- ignore case when searching
opt.smartcase = true -- case sensitive

opt.cursorline = true

-- Colors
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- Backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or insert mode start position

-- Clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
