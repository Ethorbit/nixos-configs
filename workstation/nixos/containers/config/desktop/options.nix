{ config, lib, ... }:

{
    options.ethorbit.container.desktop = with lib; {
        # Streaming is recommended for graphical acceleration.
        #
        # If streaming is off, it is to be assumed X nesting is
        # used as there are no other ways to view a containerized
        # desktop. (X nesting is software rendered only)
        #
        # You cannot use both streaming and no streaming since
        # streaming requires X in container and nesting uses
        # X from host - you can see the conflict there.
        streamed = mkOption {
            type = types.bool;
            default = true;
        };

        command = mkOption {
            type = types.str;
            default = "";
        };
    };
}
