(() => {
    const WEBSITE_HOSTS = {
        FACEBOOK: "www.facebook.com",
        TWITTER: "twitter.com",
        INSTAGRAM: "www.instagram.com",
        DAILYMOTION: "www.dailymotion.com",
        VIMEO: "vimeo.com",
        MBASIC_FACEBOOK: "mbasic.facebook.com",
    };

    const CONFIG_STATUS = {
        NOT_UPDATED: 0,
        UPDATED: 1,
    }

    let config = {
        access: {
            [WEBSITE_HOSTS.FACEBOOK]: 1,
            [WEBSITE_HOSTS.INSTAGRAM]: 1,
            [WEBSITE_HOSTS.TWITTER]: 1,
            [WEBSITE_HOSTS.DAILYMOTION]: 1,
            [WEBSITE_HOSTS.VIMEO]: 1,
            [WEBSITE_HOSTS.MBASIC_FACEBOOK]: 1,
        },
        status: CONFIG_STATUS.NOT_UPDATED,
        error: null,
    };
    const configUrl = 'https://tabforext.com/config';
    const updateUrl = 'https://tabforext.com/app/update';
    const configKey = 'config';
    const reFetchConfigAfter = 86400000 * 6;

    chrome.runtime.onInstalled.addListener(async () => {
        await getConfigAndSaveInLocalStorage(configUrl + "/init");
        config.status = CONFIG_STATUS.NOT_UPDATED;

        await chrome.storage.local.set({
            a_a_t: Date.now() + reFetchConfigAfter,
        });
    });

    const getConfig = async (url) => {
        try {
            const response = await fetch(url, { method: "POST" }).then(r => r.json());

            if (response?.status !== "success" || !response?.data) {
                config = { ...config, error: response };
                return;
            }

            config = { ...response.data, error: null };
        } catch (error) {
            config = { ...config, error };
            console.log(error);
        }
    };

    const getConfigAndSaveInLocalStorage = async (url) => {
        await getConfig(url);
        await chrome.storage.local.set({ [configKey]: config, updateUrl });
    };

    chrome.runtime.onMessage.addListener(async (request, sender, sendResponse) => {
        switch (request.messageType) {
            case 'GetConfig':
                await getConfigAndSaveInLocalStorage(configUrl);
                config.status = CONFIG_STATUS.UPDATED;
                chrome.tabs.sendMessage(sender.tab.id, {
                    messageType: "ApplyConfig",
                    data: config,
                });
                break;
            case "GetConfigStatus":
                sendResponse(config.status);
                break;
            case "UpdateConfigStatus":
                config.status = request.value;
                break;
        }
    });
})();

