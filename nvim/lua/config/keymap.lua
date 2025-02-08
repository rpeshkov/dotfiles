vim.keymap.set(
  "n",
  "<Leader>ev",
  ":vsplit $MYVIMRC<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "gx",
  ':silent execute "!open " . shellescape("<cWORD>")<CR>',
  { noremap = true }
)

-- Shifting left/right
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Yank till end of line
vim.keymap.set("n", "Y", "y$", { noremap = true, silent = true })

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z", { noremap = true })

-- Open folds when jumping through matches
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set("c", "%%", 'expand("%:h")."/"', { noremap = true, expr = true })

vim.keymap.set("n", "<leader><space>", function()
  require("fzf-lua").files()
end, { silent = true })
