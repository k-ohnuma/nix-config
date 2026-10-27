local function attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local function is_image(path)
    return path:lower():match("%.png$")
      or path:lower():match("%.jpe?g$")
      or path:lower():match("%.gif$")
      or path:lower():match("%.tiff?$")
      or path:lower():match("%.bmp$")
      or path:lower():match("%.webp$")
      or path:lower():match("%.heic$")
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "vs", api.node.open.vertical, opts("Open vertical"))
  vim.keymap.set("n", "<Leader>yy", function()
    local node = api.tree.get_node_under_cursor()
    if not node or node.type ~= "file" then
      vim.notify("nvim-tree: cursor is not on a file", vim.log.levels.WARN)
      return
    end

    if is_image(node.absolute_path) then
      local result = vim.system({ "fish", "-lc", "copyimage " .. vim.fn.shellescape(node.absolute_path) }):wait()
      if result.code ~= 0 then
        vim.notify("nvim-tree: failed to copy image", vim.log.levels.ERROR)
        return
      end

      vim.notify("nvim-tree: copied image to clipboard")
      return
    end

    local ok, lines = pcall(vim.fn.readfile, node.absolute_path)
    if not ok then
      vim.notify("nvim-tree: failed to read " .. node.absolute_path, vim.log.levels.ERROR)
      return
    end

    vim.fn.setreg("+", lines, "l")
    vim.notify("nvim-tree: copied file contents to clipboard")
  end, opts("Copy file contents"))
end

local function natural_cmp(a, b)
  if a.type ~= "directory" and b.type == "directory" then
    return false
  end
  if a.type == "directory" and b.type ~= "directory" then
    return true
  end

  local left = a.name:lower()
  local right = b.name:lower()
  if left == right then
    return false
  end

  for i = 1, math.max(#left, #right) do
    local l = left:sub(i)
    local r = right:sub(i)

    -- 先頭が数字同士なら、連続する数字を数値として比較
    if tonumber(l:sub(1, 1)) and tonumber(r:sub(1, 1)) then
      local ln = tonumber(l:match("^[0-9]+"))
      local rn = tonumber(r:match("^[0-9]+"))
      if ln ~= rn then
        return ln < rn
      end
    elseif l:sub(1, 1) ~= r:sub(1, 1) then
      return l < r
    end
  end
end

require("nvim-tree").setup({
  filters = {
    custom = {
      "^\\.git$",
      "^node_modules$",
      "^cdk\\.out$",
      "^\\.storage$",
    },
  },
  git = {
    ignore = false,
  },
  view = { adaptive_size = true },
  on_attach = attach,
  sort_by = function(nodes)
    table.sort(nodes, natural_cmp)
  end,
})
