{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.firefox = {
            enable = true;
            profiles."default" = {
                id = 0;
                name = "default";
                isDefault = true;

                search = {
                    engines = {
                        "SearxNG" = {
                            urls = [{ template = "https://searx.be/search?q={searchTerms}"; }];
                        };
                        "Amazon.com".metaData.hidden = true;
                        "eBay".metaData.hidden = true;
                        "Bing".metaData.hidden = true;
                        "Wikipedia (en)".metaData.hidden = true;
                    };
                    order = [ "DuckDuckGo" "SearxNG" "Google" ];
                    default = "DuckDuckGo";
                };

                settings = {
                    "browser.newtabpage.pinned" = "";
                    "browser.topsites.contile.enabled" = false;
                    "browser.search.defaultenginename" = "DuckDuckGo";
                    "browser.search.order.1" = "DuckDuckGo";
                };
            };
        };
    };
}
