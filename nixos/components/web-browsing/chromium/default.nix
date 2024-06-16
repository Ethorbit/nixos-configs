{ config, lib, ... }:

{
    programs.chromium = {
        enable = true;
        extensions = lib.mkDefault [
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
