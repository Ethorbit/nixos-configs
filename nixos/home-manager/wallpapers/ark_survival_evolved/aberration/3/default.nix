{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".wallpapers/ark_survival_evolved_aberration_3.jpg" = {
            source = (builtins.fetchurl {
                url = "https://cdn.wccftech.com/wp-content/uploads/2017/09/ark_aberration_2.jpg";
                sha256 = "sha256:0s4z04in79x1a1niwmkg6955fpphqq0r11hiskwfbhjh0nindns7";
            });
        };
    };
}
