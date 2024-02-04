{ config, ... }:

{
    # original url: https://wallpapercave.com/wp/wp3837751.jpg
    # the website blocks my download requests so I re-uploaded it to Dropbox.
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".wallpapers/space_4k_1.jpg" = {
            source = (builtins.fetchurl {
                url = "https://www.dropbox.com/scl/fi/2fo1wbsk9yal13fmr8pjr/4k-space-wallpaper-1.jpg?rlkey=r0esez8e9pm9su9067b0x2akz";
                sha256 = "2789dd2576b215cfa38ca7fe7c568651ac3765a12ca9dc4afd2543a62d045d0c";
            });
        };
    };
}
