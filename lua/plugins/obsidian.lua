-- ~/.config/nvim/lua/plugins/obsidian.lua
return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- stick to latest stable API
    lazy = true,
    ft = "markdown", -- load only for Markdown buffers
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        -- {
        --   name = "Common",
        --   path = "~/Nextcloud/Obsidian",  -- <-- change to your vault
        -- },
      },

      -- Daily notes (optional)
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
      },

      -- Templates (optional)
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },

      -- Completion via nvim-cmp (LazyVim has cmp)
      completion = { nvim_cmp = true, min_chars = 2 },

      -- UI niceties (safe defaults)
      ui = { enable = true },
    },

    -- Handy keymaps (feel free to change the prefix)
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open current note in Obsidian app" },
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today’s daily" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday’s daily" },
      { "gd", "<cmd>ObsidianFollowLink<cr>", desc = "Follow wiki/markdown link" },
      { "gD", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
    },
  },
}
