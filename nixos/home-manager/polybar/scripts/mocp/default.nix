{ config, ... }:

{
    imports = [
        ./toggle-play.nix
        ./song-name.nix
        ./state.nix
    ];
}
