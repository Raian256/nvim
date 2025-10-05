return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      opts = opts or {}
      opts.enable_autosnippets = true

      -- OPTIONAL: avoid collisions with Friendly-Snippets LaTeX
      require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "latex" } })

      -- Load YOUR Lua snippets
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })
    end,
  },
}
