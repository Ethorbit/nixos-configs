{ config, lib, pkgs, ... }:

{
    imports = [
        ./before-24.11.nix
        ./24.11-or-later.nix
    ];

    environment = {
        variables = {
            VDPAU_DRIVER = lib.mkDefault "va_gl";
        };
    };

    # this fixes garbage ICD errors...
    # https://discourse.nixos.org/t/nixos-issues-with-vulkan-after-upgrading-from-24-05-to-24-11/56949/8
    # I don't think it's related to 24.11 though, pretty sure stupid me always had the problem and I only
    # just found out by running vulkaninfo, lol
    environment.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
}
