vim.keymap.set(
   "n",
   "<Leader>e",
   vim.diagnostic.open_float,
   { noremap = true, silent = true }
)
vim.keymap.set(
   "n",
   "<Leader>a",
   vim.lsp.buf.code_action,
   { noremap = true, silent = true }
)

return {}
