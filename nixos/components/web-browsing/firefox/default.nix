{ config, ... }:

{
    imports = [
        ../../../home-manager/firefox
    ];

    # Disable data collection, sponsors and the saving of sensitive info
    # You should be using an encrypted password manager to save stuff, not Firefox.
    programs.firefox = {
        enable = true;

        policies = {
            "DisableTelemetry" = true;
            "DisableFirefoxStudies" = true;
            "DisablePocket" = true;
            "DisableAccounts" = true;
            "DisableFirefoxAccounts" = true;
            "DontCheckDefaultBrowser" = true;
            "DNSOverHTTPS".Enabled = true;
            "OfferToSaveLogins" = false;
        };

        preferences = {
            "gfx.webrender.all" = true; # Force enable GPU acceleration
            "media.ffmpeg.vaapi.enabled" = true;
            "widget.dmabuf.force-enabled" = true; # Required in recent Firefox for GPU acceleration (?)
            "browser.aboutConfig.showWarning" = false;
            "signon.rememberSignons" = false;
            "signon.autofillForms" = false;
            "experiments.enabled" = false;
            "extensions.pocket.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "extensions.formautofill.addresses.enabled" = false;
            "browser.newtabpage.pinned" = "";
            "browser.topsites.contile.enabled" = false;
            "browser.formfill.enable" = false;
            "browser.urlbar.suggest.pocket" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.system.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
            "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        };
    };
}
