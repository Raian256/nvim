vim.keymap.set("n", "<localleader>jt", "<cmd>Neorg journal today<CR>", { buffer = true, desc = "Neorg: journal today" })
vim.keymap.set(
  "n",
  "<localleader>jy",
  "<cmd>Neorg journal yesterday<CR>",
  { buffer = true, desc = "Neorg: journal yesterday" }
)
vim.keymap.set(
  "n",
  "<localleader>jm",
  "<cmd>Neorg journal tomorrow<CR>",
  { buffer = true, desc = "Neorg: journal tomorrow" }
)
