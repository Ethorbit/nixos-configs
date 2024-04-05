{ config, pkgs, ... }:

{
    users = {
        mutableUsers = false;

        # There's no reason for root; workstation user uses sudo
        # and containers don't use any form of root for security.
        users."root" = {
            #hashedPassword = "$6$4.rqF26SKsvG2HcV$9fdNNRHTu8FdsfiZzWOuhY8laaS5Fts42cXiqFlQJsPl4hG2HgoJA98CCgthPPwj1x5tjkFvh9kHMtotuu4t4.";
            shell = ''${pkgs.shadow}/bin/nologin'';
            hashedPassword = "!";
        };
    };
}
