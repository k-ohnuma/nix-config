{ ... }:
{
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    globalConfig = {
      settings = {
        idiomatic_version_file_enable_tools = [ "node" ];
        pipx.uvx = true;
      };

      tools = {
        bun = "latest";
        "cargo:cargo-compete" = "latest";
        "cargo:cargo-equip" = "latest";
        "cargo:cargo-nextest" = "latest";
        "cargo:cargo-udeps" = "latest";
        "cargo:sheldon" = "0.8.5";
        "cargo:sqlx-cli" = "0.7.3";
        "cargo:vsnip-cli" = "latest";
        "cargo:cargo-acj" = "latest";
        deno = "latest";
        go = "latest";
        node = "24.11.0";
        npm = "latest";
        "npm:@biomejs/biome" = "latest";
        "npm:@openai/codex" = "latest";
        "npm:aws-cdk" = "latest";
        "npm:cdktf-cli" = "latest";
        "npm:serverless" = "latest";
        "pipx:online-judge-api-client" = "latest";
        pnpm = "latest";
        python = "latest";
        rust = "1.89.0";
        rust-analyzer = "2025-11-10";
        terraform = "latest";
        uv = "latest";
      };

      tasks = {
        equiq = {
          run = ''
            cargo equip --remove docs --remove comments --minify libs --no-check ''${usage_bin:+--bin "''${usage_bin}"} > submit.rs
          '';
          usage = ''
            arg "<bin>" default=""
          '';
          description = "equip for library checker";
          alias = "eq";
        };

        eqq = {
          run = ''
            cargo equip --exclude ac-library-rs --exclude itertools --exclude num --exclude num-bigint --exclude num-decimal --exclude proconio  --exclude rust-decimal --exclude superslice --exclude regex --exclude num-traits --exclude regex --exclude easy-ext --remove docs --remove comments --minify libs --no-check ''${usage_bin:+--bin "''${usage_bin}"} > submit.rs
          '';
          usage = ''
            arg "<bin>" default=""
          '';
          description = "equip for atcoder";
        };

        "compete:test" = {
          run = ''
            cargo compete test ''${usage_id}
          '';
          usage = ''
            arg "<id>" default=""
          '';
          description = "cargo compete test <id>. alias: t";
          alias = "t";
        };

        "compete:submit" = {
          run = ''
            cargo compete submit ''${usage_id}
          '';
          usage = ''
            arg "<id>" default=""
          '';
          description = "cargo compete submit <id>. alias: s";
          alias = "s";
        };

        "compete:login" = {
          run = ''
            cargo compete login atcoder
          '';
          usage = ''
            arg "<id>" default=""
          '';
          description = "cargo compete login atcoder. alias: login";
          alias = "login";
        };

        "compete:new" = {
          run = ''
            cargo compete new ''${usage_id}
          '';
          usage = ''
            arg "<id>" default=""
          '';
          description = "cargo compete new. alias: new";
          alias = "new";
        };
      };
    };
  };
}
