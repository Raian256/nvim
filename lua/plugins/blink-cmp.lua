return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          markdown = { "path" }, -- no "buffer"
          norg = { "path" }, -- no "buffer"
          text = { "path", "snippets" }, -- no "buffer"
        },
      },
    },
  },
}
