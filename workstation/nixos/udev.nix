{ config, ... }:

{
    services.udev.extraRules = ''
    # Allows Wolf to acces /dev/uinput
    KERNEL=="uinput", SUBSYSTEM=="misc", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"

    # Move virtual keyboard and mouse into a different seat
    SUBSYSTEMS=="input", ATTRS{id/vendor}=="ab00", MODE="0660", GROUP="input", ENV{ID_SEAT}="seat9"

    # Joypads
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf X-Box One (virtual) pad", MODE="0660", GROUP="input"
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf PS5 (virtual) pad", MODE="0660", GROUP="input"
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf gamepad (virtual) motion sensors", MODE="0660", GROUP="input"
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf Nintendo (virtual) pad", MODE="0660", GROUP="input"
    '';
}
