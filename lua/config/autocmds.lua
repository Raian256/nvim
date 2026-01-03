-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- Soft-wrap long lines for
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "markdown", "norg" },
  callback = function()
    -- core soft wrap
    vim.opt_local.wrap = true -- enable visual wrapping
    vim.opt_local.linebreak = true -- wrap at word boundaries (not mid-word)

    -- nicer wrapped-line alignment
    vim.opt_local.breakindent = true -- keep indent on wrapped lines
    vim.opt_local.breakindentopt = "sbr" -- use showbreak as extra indent hint
    vim.opt_local.showbreak = "↳ " -- prefix on wrapped parts (pick any)

    -- optional QoL
    -- vim.opt_local.display:append("lastline") -- show last line even if long
    -- vim.opt_local.whichwrap = "b,s,<,>,[,]" -- allow cursor to move across wraps
    -- If you use listchars and don't want wrap glyphs crowded:
    -- vim.opt_local.list = false
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.jrnl",
  callback = function()
    -- choose what you want:
    vim.bo.filetype = "markdown" -- or "jrnl" if you define it
  end,
})
