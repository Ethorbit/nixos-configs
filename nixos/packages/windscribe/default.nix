{ config, lib, pkgs, ... }:

{
    # Yeah I gave up on this one half-way through after reading some posts that destroyed my confidence. Windscribe on NixOS seems to be a lost cause..
    # Instead I created a private Proxmox bridge and gave it an Ubuntu-based network gateway Virtual Machine that is running the beloved Windscribe GUI inside, 
    # then did all the iptables NAT magic to enable connectivity. With this setup, you access the GUI with SPICE as the designated Gateway Proxmox user.

    #imports = [
    #    ../ctrld
    #];

    #options.ethorbit.pkgs.windscribe = with pkgs; with config.ethorbit.pkgs; with lib; mkOption {
    #    type = types.package;
    #    default = (stdenv.mkDerivation {
    #        name = "windscribe";
    #        src = (fetchFromGitHub {
    #            owner = "Windscribe";
    #            repo = "Desktop-App";
    #            rev = "2974d6d5d720a01499b29ca9ee21cc7dab3a306f";
    #            hash = "sha256-A1JPEayJt44Jk88dwWrlnNDFTA9C5tWuziVbu7blAPQ=";
    #        });

    #        phases = [ "buildPhase" ];
    #        
    #        buildPhase = ''
    #            # TODO if I ever bother to come back to this:
    #            # figure out why TF it's trying to create a directory in a nix store path despite explicitly using /tmp
    #            cp -rap $src/* /tmp/
    #            export HOME=/tmp
    #            cd $HOME/tools/deps
    #            bash ./install_qt
    #            #mkdir /tmp/.venv
    #            #python3 -m venv /tmp/.venv
    #            #source /tmp/.venv/bin/activate
    #            #pip install -r $src/tools/requirements.txt
    #        '';
    #            #./install_openvpn_dco
    #            #./install_wintun
    #            #./install_wireguard
    #            #./install_wstunnel
    #            #ls -laht
    #            #ln "${ctrld}/bin/ctrld" $src/tools/deps/build-libs/ctrld/ctrld
    #            #cd $src/tools
    #            #./build_all

    #        buildInputs = [
    #            bash
    #            coreutils
    #            curl
    #            python3
    #            #python311Packages.pip
    #            python311Packages.colorama
    #            python311Packages.pyyaml
    #            python311Packages.requests
    #            ctrld
    #        ];

    #        # $out
    #        #installPhase = ''
    #        #
    #        #'';
    #   });
    #};
}
