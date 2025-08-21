{ config, ... }:

{
    services = {
        openssh = {
            enable = true;
            settings = {
                PermitRootLogin = "no";
            };
        };

        blueman.enable = true;
    };
}
