{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        # original url: https://wallpapercave.com/wp/wp9720179.png
        # the website blocks my download requests so I re-uploaded it to Dropbox.
        home.file.".wallpapers/ark_survival_evolved_aberration_6.jpg" = {
            source = (builtins.fetchurl {
                url = "https://www.dropbox.com/scl/fi/xw72s620vlry53h2h4ylf/ark-aberration-surface.png?rlkey=u14xkhjcr515uadoqpund5pu9";
                sha256 = "sha256:1mglbd7ribwlbhg8l5mqwja4yl0ipymi5fgkyzy0wggf67n5gq1f";
            });
        };
    };
}
