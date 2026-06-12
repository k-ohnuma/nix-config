return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = {
      { "<Leader>ph", "<cmd>Gitsigns preview_hunk<CR>", mode = "n" },
      { "<Leader>nh", "<cmd>Gitsigns next_hunk<CR>", mode = "n" },
      {
        "<Leader>sh",
        function()
          local gs = require("gitsigns")
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        mode = "v",
      },
      {
        "<Leader>rh",
        function()
          local gs = require("gitsigns")
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        mode = "v",
      },
    },
    opts = {},
  },
  {
    "APZelos/blamer.nvim",
    event = "BufRead",
    init = function()
      vim.g.blamer_enabled = true
    end,
  },
  {
    "rhysd/git-messenger.vim",
    event = "BufRead",
    init = function()
      vim.g.git_messenger_no_default_mappings = true
    end,
    keys = {
      { "<Leader>ms", "<cmd>GitMessenger<CR>", mode = "n" },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    keys = {
      { "<Leader>dfo", "<cmd>DiffviewFileHistory<CR>", mode = "n" },
      { "<Leader>dfc", "<cmd>DiffviewClose<CR>", mode = "n" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
      })
      vim.keymap.set("n", "<leader>cc", "<Plug>(git-conflict-ours)", {
        desc = "Conflict: choose ours/current",
      })

      vim.keymap.set("n", "<leader>ci", "<Plug>(git-conflict-theirs)", {
        desc = "Conflict: choose theirs/incoming",
      })

      vim.keymap.set("n", "<leader>cb", "<Plug>(git-conflict-both)", {
        desc = "Conflict: choose both",
      })

      vim.keymap.set("n", "<leader>c0", "<Plug>(git-conflict-none)", {
        desc = "Conflict: choose none",
      })

      vim.keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)", {
        desc = "Next conflict",
      })

      vim.keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)", {
        desc = "Previous conflict",
      })
    end,
  },
}
