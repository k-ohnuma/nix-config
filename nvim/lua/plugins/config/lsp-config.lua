require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "rust_analyzer", "ts_ls" },
  automatic_enable = true,
})

local home = vim.env.HOME or "~"
local nix_config_relative_path = vim.env.NIX_CONFIG_RELATIVE_PATH or "nix/nix-config"
local nix_darwin_host = vim.env.NIX_DARWIN_HOST or "user"
local nix_config_root = vim.fs.normalize(home .. "/" .. nix_config_relative_path)
local flake_expr = string.format("(builtins.getFlake %q)", nix_config_root)

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

do
  local orig_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
    if result and result.diagnostics and ctx and ctx.client_id then
      local client = vim.lsp.get_client_by_id(ctx.client_id)

      if client and (client.name == "biome" or client.name == "biomejs") then
        local filtered = {}

        for _, d in ipairs(result.diagnostics) do
          -- source=biome && code=assist/source/organizeImports だけ除外
          if not (d.source == "biome" and d.code == "assist/source/organizeImports") then
            table.insert(filtered, d)
          end
        end

        result = vim.deepcopy(result)
        result.diagnostics = filtered
      end
    end

    return orig_handler(err, result, ctx, config)
  end
end

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      -- 起動直後の先読み解析を無効化する。
      cachePriming = {
        enable = true,
      },
      cargo = {
        -- 有効にする feature を明示する設定。
        -- "all" にすると --all-features 相当になり、解析対象が増えて重くなりやすい。
        features = {},
        -- すべての target を見るかどうか。
        -- デフォルトは true。
        -- true だと test / bench / example なども含めて広く解析しやすい。
        allTargets = false,
        buildScripts = {
          enable = false,
        },
      },
      -- procedural macro を展開して解析するかどうか。
      procMacro = {
        enable = true,
      },
      -- 保存時に cargo check 相当を走らせて診断を出す
      checkOnSave = true,
      check = {
        -- 保存時チェックでも --all-targets を使うか。
        allTargets = false,
      },
    },
  },
  on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
})

vim.lsp.config("ts_ls", {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  settings = {
    diagnostics = { ignoredCodes = { 6133 } },
    completions = { completeFunctionCalls = true },
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.config("nixd", {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      options = {
        ["nix-darwin"] = {
          expr = flake_expr .. ".darwinConfigurations." .. string.format("%q", nix_darwin_host) .. ".options",
        },
        ["home-manager"] = {
          expr = flake_expr
            .. ".darwinConfigurations."
            .. string.format("%q", nix_darwin_host)
            .. ".options.home-manager.users.type.getSubOptions []",
        },
      },
    },
  },
})

vim.lsp.enable("nixd")
