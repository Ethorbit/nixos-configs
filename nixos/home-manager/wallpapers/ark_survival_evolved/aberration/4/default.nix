{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".wallpapers/ark_survival_evolved_aberration_4.jpg" = {
            source = (builtins.fetchurl {
                url = "https://wallpaperaccess.com/full/7153576.jpg";
                sha256 = "sha256:09k63dbj24wqb8vqn6zhxkrd1kggwhvmykw4y34g1sq8xmwkd5hr";
            });
        };
    };
}
