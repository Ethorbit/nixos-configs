let
    ethorbit = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos";
    nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMGNAhCknWm5sYlpao654MffJx4I6HNlZhocSatNrss ethorbit@space";
    # Due to Steamdeck not having full-disk encryption, its key is prone to getting stolen from device theft.
    # It will only be attached to hand-picked secrets and nothing else..
    steamdeck = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPfwGjrtzcX2ELQah0uQAbFEv0eAjAHPvRHMB7Jkegx3 root@nixos";
in
{
    "nixos/secrets/restic/repos/workstation/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/nzc/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/main_os_storage/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/android_pixel_primary/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/android_pixel_dark/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/android_pixel_high/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/users/primary/pass.age".publicKeys = [ ethorbit nixos steamdeck ];

    "homenas/nixos/secrets/samba/users/ethorbit/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/nixos/secrets/samba/users/headlessnvidia/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/nixos/secrets/samba/users/nzc/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/nixos/secrets/samba/users/hax/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/nixos/secrets/samba/users/gaming/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/nixos/secrets/samba/users/videos/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/nixos/secrets/samba/users/ai/creds.age".publicKeys = [ ethorbit nixos ];

    "nzc/nixos/secrets/networking/firewall/ISP_CIDR_one.age".publicKeys = [ ethorbit nixos ];
    "nzc/nixos/secrets/networking/firewall/ISP_CIDR_two.age".publicKeys = [ ethorbit nixos ];
    "nzc/nixos/profiles/selfhosted/secrets/networking/vpn/private.key.age".publicKeys = [ ethorbit nixos ];
    "nzc/nixos/profiles/selfhosted/secrets/networking/vpn/preshared.key.age".publicKeys = [ ethorbit nixos ];
}
