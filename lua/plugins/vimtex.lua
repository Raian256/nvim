return {
  -- latex
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_use_temp_files = 0
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "build", -- map to latexmk $aux_dir
        out_dir = "build", -- map to latexmk $out_dir
        continuous = 1,
        callback = 1,
        options = { "-file-line-error", "-synctex=1", "-interaction=nonstopmode" },
      }
      vim.g.vimtex_view_use_temp_files = 0
      -- Hide badbox noise in VimTeX quickfix
      vim.g.vimtex_quickfix_ignore_filters = {
        [[Overfull \\hbox]],
        [[Underfull \\hbox]],
        [[Loose \\hbox]],
        [[Underfull \\vbox]],
      }

      -- Don't pop quickfix open just for warnings
      vim.g.vimtex_quickfix_open_on_warning = 0
    end,
  },
}
