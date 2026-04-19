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
        # for procon
        "cargo:cargo-equip" = "latest";
        "cargo:cargo-compete" = "latest";
        "cargo:cargo-udeps" = "latest";
        "cargo:cargo-acj" = "latest";
        "cargo:cargo-atcoder" = "latest";
        "pipx:online-judge-api-client" = "latest";
        # vsnip
        "cargo:vsnip-cli" = "latest";
        "npm:@openai/codex" = "latest";
        "npm:cdktf-cli" = "latest";
        # rust = "1.89.0";
        # rust-analyzer = "2025-11-10";
      };
    };
  };
}
