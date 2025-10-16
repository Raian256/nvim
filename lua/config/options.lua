-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us", "es" }
vim.opt.clipboard = "unnamedplus"

vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "no" -- removes the gutter entirely
