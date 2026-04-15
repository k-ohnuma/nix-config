{ userName, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = userName;
    # - 設定がどの Home Manager release と互換であるかを指定
    # - 新しいHome Manager releaseに後方互換のない変更が入った時の破壊を避ける
    # - Home Manager を更新しても、この値を変える必要はない
    stateVersion = "25.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
