{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".wallpapers/ark_survival_evolved_aberration_5.jpg" = {
            source = (builtins.fetchurl {
                url = "https://wallpaperaccess.com/full/6274493.jpg";
                sha256 = "sha256:13p54d9p013xyq5zkbvqj7vawxmkq7fy86528y24hvyrp8v0zsfc";
            });
        };
    } ];
}
