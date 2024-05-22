{ config, lib, pkgs, ... }:

{
    programs.chromium = with lib; {
        enable = mkDefault false;
        extensions = mkDefault [
            # Ublock Origin
            "cjpalhdlnbpafiamejdnhcphjbkeiagm"
            # NoScript
            "doojmbjmlfjjnbmnoijecmcbfeoakpjm"
            # SponsorBlock
            "mnjggcdmjocbbbhaepdhchncahnbgone"
            # Return YouTube Dislike
            "gebbhagfogifgggkldgodflihgfeippi"
        ];
    };
}
