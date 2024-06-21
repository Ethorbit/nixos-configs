{ config, lib, ... }:

{
    programs.chromium = {
        enable = true;

        extraOpts = {
            "BrowserSignin" = 0;
            "SyncDisabled" = true;
            "PasswordManagerEnabled" = false;
            "PasswordSharingEnabled" = false;
            "SpellcheckEnabled" = true;
            "SpellcheckLanguage" = [
                "en-US"
            ];
            "DefaultBrowserSettingEnabled" = false;
            "DefaultGeolocationSetting" = 2;
            "DnsOverHttpsMode" = "secure";
            "HttpsOnlyMode" = "force_enabled";
            "DefaultSearchProviderSearchURL" = "https://duckduckgo.com/?q={searchTerms}";
            "AutofillAddressEnabled" = false;
            "AutoFillEnabled" = false;
            "ImportAutofillFormData" = false;
            "ImportSavedPasswords" = false;
            "ImportHistory" = false;
        };

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
