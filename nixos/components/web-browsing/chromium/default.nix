{ config, lib, ... }:

{
    imports = [
        ./wrappers.nix
    ];

    config = {
        programs.chromium = {
            enable = true;

            # Apparently Brave won't let users uninstall these
            # Even if it's done in Home Manager
            #
            # Let's just keep security-focused ones here
            # Let user install anything else.
            extensions = lib.mkDefault [
                # Ublock Origin
                "cjpalhdlnbpafiamejdnhcphjbkeiagm"
                # NoScript
                "doojmbjmlfjjnbmnoijecmcbfeoakpjm"
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
                "extensions" = {
                    "pinned_extensions" = config.programs.chromium.extensions;
                };
                "session" = {
                    "restore_on_startup" = 1;
                };
            };
        };
    };
}
