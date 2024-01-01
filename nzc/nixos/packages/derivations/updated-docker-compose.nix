# Slightly modified docker-compose derivation from: https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/applications/virtualization/docker/compose.nix
{ lib, pkgs }:

pkgs.buildGoModule rec {
  pname = "docker-compose";
  version = "2.18.1";

  src = pkgs.fetchFromGitHub {
    owner = "docker";
    repo = "compose";
    rev = "v${version}";
    hash = "sha256-g8XaMvKt3tR7a7kq+n4ueDXx9iWuAu02ONb73W23ZGY=";
  };

  postPatch = ''
    # entirely separate package that breaks the build
    rm -rf e2e/
  '';

  vendorHash = "sha256-BeW39XN1CvPCCq4otX+Il2dGGcjGrTMzc4iSXmQZFmw=";

  ldflags = [ "-X github.com/docker/compose/v2/internal.Version=${version}" "-s" "-w" ];

  doCheck = false;
  installPhase = ''
    runHook preInstall
    install -D $GOPATH/bin/cmd $out/libexec/docker/cli-plugins/docker-compose

    mkdir -p $out/bin
    ln -s $out/libexec/docker/cli-plugins/docker-compose $out/bin/docker-compose
    runHook postInstall
  '';

  meta = with lib; {
    description = "Docker CLI plugin to define and run multi-container applications with Docker";
    homepage = "https://github.com/docker/compose";
    license = licenses.asl20;
    maintainers = with maintainers; [ babariviere ];
  };
}
