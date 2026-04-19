vim.cmd("syntax on")
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
vim.cmd([[
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]])

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    if vim.api.nvim_buf_get_option(0, "modifiable") then
      vim.api.nvim_command([[%s/\%V\r//ge]])
    end
  end,
})

vim.api.nvim_create_user_command("E", function()
  vim.cmd("silent! e")
  vim.cmd("silent! Gitsigns refresh")
  vim.cmd("silent! NvimTreeRefresh")
  vim.cmd("silent! redrawtabline")
  vim.cmd("silent! redrawstatus")
end, {})

vim.api.nvim_create_user_command("BB", function()
  if vim.bo.buftype ~= "" or not vim.bo.modifiable or vim.bo.binary then
    return
  end

  if vim.fn.search([[\r]], "nw") == 0 then
    return
  end

  vim.cmd([[silent! keepjumps keeppatterns %s/\r//ge]])
end, { desc = "Remove CR (^M) in current buffer" })

vim.api.nvim_create_user_command(
  "VsnipRefresh",
  "execute 'edit' expand('~/.vsnip/' . &filetype . '.json') | checktime | write | b#",
  {}
)
