let 
	ethorbit = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBqJ/nN5CSeJusNoyw0x5ly6IlCcl46UNkG6xGzbTll";
in
{
	"users.root.pass.age".publicKeys = [ ethorbit ];
	"users.ethorbit.pass.age".publicKeys = [ ethorbit ];
}
	
