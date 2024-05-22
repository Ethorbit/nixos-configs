{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        # original url: https://wallpapercave.com/wp/wp9285238.jpg
        # the website blocks my download requests so I re-uploaded it to Dropbox.
        home.file.".wallpapers/ark_survival_evolved_genesis_1.jpg" = {
            source = (builtins.fetchurl {
                url = "https://www.dropbox.com/scl/fi/04z20uubl64as0d7bun4s/ark-genesis-shadowmane.webp?rlkey=0v6nkjb3uitfq0puxf04pllwu";
                sha256 = "sha256:0p79lsby7d13rqbl8c31lybh4d2xihwiivz7d6ipqadl7lahxzdx";
            });
        };
    };
}
