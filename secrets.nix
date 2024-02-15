let
    ethorbit = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos";
in
{
    "nixos/secrets/restic/repos/nzc/pass.age".publicKeys = [ ethorbit ];
    "homenas/nixos/secrets/samba/users/ethorbit/creds.age".publicKeys = [ ethorbit ];
    "homenas/nixos/secrets/samba/users/nzc/creds.age".publicKeys = [ ethorbit ];
    "workstation/secrets/users/root/pass.age".publicKeys = [ ethorbit ];
    "workstation/secrets/users/ethorbit/pass.age".publicKeys = [ ethorbit ];
    "nzc/nixos/secrets/users/nzc/pass.age".publicKeys = [ ethorbit ];
    "nzc/nixos/secrets/networking/firewall/ISP_CIDR_one.age".publicKeys = [ ethorbit ];
    "nzc/nixos/secrets/networking/firewall/ISP_CIDR_two.age".publicKeys = [ ethorbit ];
    "nzc/nixos/selfhosted/secrets/networking/vpn/private.key.age".publicKeys = [ ethorbit ];
    "nzc/nixos/selfhosted/secrets/networking/vpn/preshared.key.age".publicKeys = [ ethorbit ];
}
