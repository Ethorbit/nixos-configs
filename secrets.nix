let
    ethorbit = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos";
    nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMGNAhCknWm5sYlpao654MffJx4I6HNlZhocSatNrss ethorbit@space";
    # Due to Steamdeck not having full-disk encryption, its key is prone to getting stolen from device theft.
    # It will only be attached to hand-picked secrets and nothing else..
    steamdeck = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPfwGjrtzcX2ELQah0uQAbFEv0eAjAHPvRHMB7Jkegx3 root@nixos";
    # Just gameservers
    nzc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHOEP7JKB15aSFnFsVmW7C0RToOhn5qusQ5d9u4+8JA+ nzc";
in
{
    "nixos/secrets/build-machines/primary/sshkey.age".publicKeys = [ ethorbit nixos steamdeck ];
    "nixos/secrets/users/primary/pass.age".publicKeys = [ ethorbit nixos steamdeck nzc ];
    "nixos/secrets/restic/repos/workstation/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/ai/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/nzc/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/main_os_storage/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/android_pixel_primary/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/android_pixel_dark/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/android_pixel_high/pass.age".publicKeys = [ ethorbit nixos ];
    "nixos/secrets/restic/repos/android_pixel_doc/pass.age".publicKeys = [ ethorbit nixos ];

    "homenas/secrets/samba/users/ethorbit/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/secrets/samba/users/headlessnvidia/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/secrets/samba/users/nzc/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/secrets/samba/users/hax/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/secrets/samba/users/gaming/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/secrets/samba/users/videos/creds.age".publicKeys = [ ethorbit nixos ];
    "homenas/secrets/samba/users/ai/creds.age".publicKeys = [ ethorbit nixos ];

    "nzc/profiles/selfhosted/secrets/networking/vpn/private.key.age".publicKeys = [ ethorbit nixos nzc ];
    "nzc/profiles/selfhosted/secrets/networking/vpn/preshared.key.age".publicKeys = [ ethorbit nixos nzc ];
}
