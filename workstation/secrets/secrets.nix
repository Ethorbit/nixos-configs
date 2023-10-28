let
	ethorbit = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos";
in
{
	"users.root.pass.age".publicKeys = [ ethorbit ];
	"users.ethorbit.pass.age".publicKeys = [ ethorbit ];
}
