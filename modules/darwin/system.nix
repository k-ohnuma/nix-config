{ ... }:
{
  time.timeZone = "Asia/Tokyo";
  system = {
    defaults = {
      menuExtraClock.Show24Hour = true;
      dock = {
        tilesize = 50;
        autohide = true;
        launchanim = true;
        show-process-indicators = true;
        show-recents = false;
      };
    };
  };
}
