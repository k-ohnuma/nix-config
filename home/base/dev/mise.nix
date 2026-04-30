{ ... }:
{
  programs.mise = {
    enable = true;
    enableFishIntegration = false;
    enableZshIntegration = false;

    globalConfig = {
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
        # cdk(nixpkgsのバージョン更新が遅いので)
        "npm:aws-cdk" = "latest";
        "npm:cdktf-cli" = "latest";
        # npm(min-release-ageの設定が11.10.0)からしかできないので
        "npm" = "latest";
      };
    };
  };
}
