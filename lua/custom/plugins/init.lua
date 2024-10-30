return {
  -- Add nvim-autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Add code_runner.nvim 
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        filetype = {
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt"
          },
          python = "python3 -u",
          typescript = "deno run",
          rust = {
            "cd $dir &&",
            "rustc $fileName &&",
            "$dir/$fileNameWithoutExt"
          },
          c = function(...)
            local c_base = {
              "cd $dir &&",
              "gcc $fileName -o",
              "/tmp/$fileNameWithoutExt",
            }
            local c_exec = {
              "&& /tmp/$fileNameWithoutExt &&",
              "rm /tmp/$fileNameWithoutExt",
            }
            vim.ui.input({ prompt = "Add more args:" }, function(input)
              c_base[4] = input
              require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
            end)
          end,
          tex = "pdflatex $fileName"
        },
      })

      -- Keybindings for code_runner
      vim.keymap.set("n", "<leader>R", ":RunCode<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>Rf", ":RunFile<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>Rft", ":RunFile tab<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>Rp", ":RunProject<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>Rc", ":RunClose<CR>", { noremap = true, silent = false })
    end,
  }
}
