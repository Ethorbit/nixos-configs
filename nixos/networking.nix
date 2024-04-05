{ config, lib, ... }:

{
    networking = {
        # I am defaulting this to false since most people use a single
        # ethernet or wifi interface and it's a more pleasant
        # naming scheme to work with in that scenario.
        usePredictableInterfaceNames = lib.mkDefault false;
    };
}
