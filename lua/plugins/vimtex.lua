return {
  -- latex
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-pdflua", -- default for all projects
      }
      vim.g.vimtex_view_use_temp_files = 2
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "build", -- map to latexmk $aux_dir
        out_dir = "build", -- map to latexmk $out_dir
        continuous = 1,
        callback = 1,
        options = {
          "-synctex=1",
          "-interaction=nonstopmode",
          -- reduce time of compilation when errors are found
          "-file-line-error",
          "-halt-on-error",
          "-recorder",
        },
      }
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
