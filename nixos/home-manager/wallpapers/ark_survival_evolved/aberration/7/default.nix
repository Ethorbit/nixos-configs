{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        # this amazing image was from a blog that was deleted
        # I have reuploaded the image to Dropbox
        home.file.".wallpapers/ark_survival_evolved_aberration_7.jpg" = {
            source = (builtins.fetchurl {
                url = "https://www.dropbox.com/scl/fi/09rkbqwujsegp4ycjoi27/ark-aberration-glowtail-cave.jpg?rlkey=xwda8eu4njllxwri91v6200cr";
                sha256 = "sha256:10fjl0v6xlv50irwxyakhs4qsrb5nnv95kxyr1kwsv51ik9qizrz";
            });
        };
    };
}
