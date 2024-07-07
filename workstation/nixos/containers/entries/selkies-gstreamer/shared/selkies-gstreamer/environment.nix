{ config, ... }:

{
    # Shows indicator on any window using VirtualGL
    environment.variables = {
        VGL_LOGO = "1";
    };
}
