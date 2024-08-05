{ config, lib, ... }:

{
    imports = [
        ./wrappers.nix
    ];

    config = {
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

            # Improve security and privacy, disallow saving / filling of sensitive data
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
                "DefaultSearchProviderEnabled" = true;
                "DefaultSearchProviderName" = "DuckDuckGo";
                "DefaultSearchProviderSearchURL" = "https://duckduckgo.com/?q={searchTerms}";
                "AutofillAddressEnabled" = false;
                "AutoFillEnabled" = false;
                "ImportAutofillFormData" = false;
                "ImportSavedPasswords" = false;
                "ImportHistory" = false;
            };

            initialPrefs = {
                "pinned_extensions" = config.programs.chromium.extensions;
                "session" = {
                    "restore_on_startup" = 1;
                };
                "browser" = {
                    "confirm_to_quit" = true;
                };
            };
        };
    };
}
