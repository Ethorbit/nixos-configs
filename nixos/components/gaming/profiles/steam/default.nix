{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        steam
    ];

    #programs.steam = {
        #enable = true;
        # ^ this never builds, always errors out
        # and even worse, no one has ever reported it before
        # error: builder for '/nix/store/4k4b3w2ri7hhfxihz8iv1nygcc11nh6x-steam-fhs.drv' failed with exit code 1;
        #   last 3 log lines:
        #   > /nix/store/z3biizw14y7gg4ig4f1fjmdnpl9ck7az-steam-fhs /build
        #   > /nix/store/z3biizw14y7gg4ig4f1fjmdnpl9ck7az-steam-fhs/usr /nix/store/z3biizw14y7gg4ig4f1fjmdnpl9ck7az-steam-fhs /build
        #   > cp: cannot stat '/nix/store/vm7xd9xm2d6ps5pid2vgc6bvymfgvcqn-steam-usr-target/lib/lib64': No such file or directory
        #
        # I have no idea wtf it's on about, so I've gone with installing the package and launching steam like normal.
    #};
}
