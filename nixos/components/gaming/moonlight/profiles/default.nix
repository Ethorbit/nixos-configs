{ config, lib, ... }:

{
    ethorbit.components.gaming.dependencies.gamescope.wrappers."moonlight" = {};

    services.ananicy = {
        extraRules = [
            {
                name = "moonlight";
                nice = -20;
            }
        ];
    };
}
