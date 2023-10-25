/* eslint-disable no-undef */
(() => {
    let lastVideoArray = [];
    setInterval(async () => {
        let websiteHostAccess = {};
        let isVideoDisplayed = false;
        await chrome?.storage?.local
            ?.get(["config", "isVideoDisplayed"])
            ?.then((result) => {
                websiteHostAccess = result?.config?.access || {};
                isVideoDisplayed = result?.isVideoDisplayed?.result;
            });

        const updatePopupData = (videoDataArray, updatedVideoDataArray) => {
            if (
                !isVideoDisplayed ||
                !isVideoIdInArraysEqual(videoDataArray, lastVideoArray)
            ) {
                chrome?.runtime?.sendMessage({
                    messageType: "UpdatePopupData",
                    data: updatedVideoDataArray?.length
                        ? updatedVideoDataArray
                        : videoDataArray,
                });
                lastVideoArray = videoDataArray;
            }
        };

        if (!websiteHostAccess[window.location.host]) {
            return;
        }

        if (window.location.host === WEBSITE_HOSTS.FACEBOOK) {
            // Logic for Facebook
            const videoTags = document.querySelectorAll("video");
            const videosArray = videoTags.length ? [...videoTags] : [];

            const videoDataArray = videosArray.map((item, index) => {
                if (window.location.href?.includes(VIDEO_REF_PART_WATCH)) {
                    // Logic for video feed  (/watch?v=*ID*)
                    const mainItemParent = getThirteenthParentOfItem(item);
                    const postedDate = mainItemParent?.querySelector(
                        'span > a[tabindex="0"][aria-label]'
                    );
                    const videoNameWrapper = mainItemParent?.querySelector(
                        'div[class] > span[dir="auto"][class]'
                    );
                    const videoSpansList = mainItemParent?.querySelectorAll(
                        'div[class] > span[dir="auto"][class]'
                    );

                    const isItMainVideo =
                        mainItemParent?.children?.[0]?.innerText !== "";
                    const postTitle = isItMainVideo
                        ? videoNameWrapper?.innerText || UNNAMED_VIDEO
                        : videoSpansList?.[2]?.innerText || UNNAMED_VIDEO;

                    const videoRef = postedDate?.href;
                    const videoRefSplitted = isItMainVideo
                        ? videoRef?.split("/")
                        : videoRef.split("&");
                    const videoShortRef =
                        extractShortRefFromArray(videoRefSplitted);

                    if (isVideoIdValid(videoShortRef)) {
                        return {
                            videoName: cutLongName(postTitle),
                            videoRef: videoShortRef,
                            videoFrom: WEBSITE.FACEBOOK,
                        };
                    }
                } else if (
                    window.location.href?.includes(VIDEO_REF_PART_VIDEOS)
                ) {
                    // Logic for facebook video feed (*ID*/videos/*ID*)
                    const mainItemParent = getThirteenthParentOfItem(
                        getFifthParentOfItem(item)
                    );
                    const postedDate = mainItemParent?.querySelector(
                        'span > a[tabindex="0"][aria-label][role="link"] > span'
                    )?.parentElement;
                    const videoNameWrapper = mainItemParent?.querySelector(
                        'div[class] > span[dir="auto"][class] > span[class]'
                    );

                    const postTitle =
                        videoNameWrapper?.innerText || UNNAMED_VIDEO;
                    const videoRef = postedDate?.href;
                    const videoRefSplitted = videoRef?.includes(
                        VIDEO_REF_PART_VIDEOS
                    )
                        ? videoRef?.split("/")
                        : videoRef?.split("&");
                    const videoShortRef =
                        extractShortRefFromArray(videoRefSplitted);

                    if (isVideoIdValid(videoShortRef)) {
                        return {
                            videoName: cutLongName(postTitle),
                            videoRef: videoShortRef,
                            videoFrom: WEBSITE.FACEBOOK,
                        };
                    }
                } else if (
                    !window.location.href?.includes(VIDEO_REF_PART_WATCH) ||
                    !window.location.href?.includes(VIDEO_REF_PART_VIDEOS)
                ) {
                    // Logic for facebook feed & groups & profiles

                    const mainItemParent = getFifthParentOfItem(
                        getThirteenthParentOfItem(item)
                    );
                    const openFullScreenVideoLink =
                        mainItemParent?.querySelector(
                            'span > span > span > a[tabindex="0"][aria-label][role="link"] > i'
                        );
                    const videoNameWrapper = mainItemParent?.querySelector(
                        'div[style="text-align: start;"]'
                    );
                    const accountNameWrapper = mainItemParent?.querySelectorAll(
                        'div > a[role="link"][tabindex="0"] > span > span'
                    )?.[index];

                    const postTitle =
                        videoNameWrapper?.innerText ||
                        accountNameWrapper?.innerText ||
                        UNNAMED_VIDEO;
                    const videoRef =
                        openFullScreenVideoLink?.parentElement?.href;
                    const videoRefSplitted = videoRef?.includes("/videos/")
                        ? videoRef?.split("/")
                        : videoRef?.split("&");
                    const videoShortRef =
                        extractShortRefFromArray(videoRefSplitted);

                    if (isVideoIdValid(videoShortRef)) {
                        return {
                            videoName: cutLongName(postTitle),
                            videoRef: videoShortRef,
                            videoFrom: WEBSITE.FACEBOOK,
                        };
                    }
                }
                return {
                    videoName: undefined,
                    videoRef: undefined,
                    videoFrom: WEBSITE.FACEBOOK,
                };
            });

            // extract video from URL
            const splittedHref = window.location.href.split("/");
            const shortRefFromPageURL = extractShortRefFromArray(splittedHref);
            const doesVideoArrayContainsUrlId = videoDataArray.find(
                (element) => element.videoRef === shortRefFromPageURL
            );

            if (
                shortRefFromPageURL &&
                !doesVideoArrayContainsUrlId &&
                window.location.href?.includes(PAGE_REF_PART_WATCH)
            ) {
                videoDataArray.push({
                    videoName: shortRefFromPageURL,
                    videoRef: shortRefFromPageURL,
                });
            }

            updatePopupData(videoDataArray);
        } else if (window.location.host === WEBSITE_HOSTS.TWITTER) {
            // logic for Twitter
            const videoTags = document.querySelectorAll("video");
            const videosArray = videoTags.length ? [...videoTags] : [];
            const videoDataArray = videosArray.map((item) => {
                const mainItemParent = getThirteenthParentOfItem(
                    getFifthParentOfItem(item)
                );
                const postedDate = mainItemParent?.querySelector(
                    'div > a[href][aria-label][role="link"] > time[datetime]'
                )?.parentElement;
                const videoRef = postedDate?.href;
                const shortRef = videoRef?.replace(/\D/g, "");
                const videoNameWrapper = mainItemParent?.querySelector(
                    'div[dir="auto"][data-testid="tweetText"][lang]'
                );
                const videoNameArray = [...videoNameWrapper?.children].map(
                    (item) => item.innerText
                );
                const postTitle = videoNameArray.length
                    ? videoNameArray.join(" ")
                    : UNNAMED_VIDEO;

                if (shortRef) {
                    return {
                        videoName: cutLongName(postTitle),
                        videoRef: shortRef,
                        videoFrom: WEBSITE.TWITTER,
                    };
                }

                return {
                    videoName: undefined,
                    videoRef: undefined,
                    videoFrom: WEBSITE.TWITTER,
                };
            });

            updatePopupData(videoDataArray);
        } else if (window.location.host === WEBSITE_HOSTS.INSTAGRAM) {
            // logic for Instagram
            const articles = [...document.querySelectorAll("article")];
            const videoDataArray = articles?.map((article) => {
                const videosList = [...article?.querySelectorAll("video")];
                const profileWhoPosted = article.querySelector(
                    'div[class] > div[class] > div[class] > div[class] > div[class] > div[class] > a[href][role="link"][tabindex="0"]'
                );
                const profileName = profileWhoPosted?.innerText;

                const videoData = videosList?.map((item) => {
                    if (item?.src?.includes("www.instagram.com")) {
                        const shortRefLink = [
                            ...article.querySelectorAll(
                                'section > div > div > span > a[href][role="link"][tabindex="0"] > span'
                            ),
                        ][0];

                        const videoRef = shortRefLink?.parentElement?.href;
                        const videoRefSplitted = videoRef?.split("/");
                        const videoShortRef =
                            videoRefSplitted?.[videoRefSplitted.length - 3];
                        const downloadVideoURL =
                            videoShortRef &&
                            `${URL_FOR_INSTAGRAM_VIDEO_DOWNLOADING}%22${videoShortRef}%22}`;
                        return {
                            videoName: cutLongName(profileName),
                            videoRef: downloadVideoURL,
                            isVideoReadyToDownloading: false,
                            videoFrom: WEBSITE.INSTAGRAM,
                        };
                    } else {
                        return {
                            videoName: cutLongName(profileName),
                            videoRef: item.src,
                            isVideoReadyToDownloading: true,
                            videoFrom: WEBSITE.INSTAGRAM,
                        };
                    }
                });
                return videoData;
            });
            const updatedVideoDataArray = videoDataArray.map((x) => ({
                videoName: x?.[0]?.videoName,
                videoRef: x?.[0]?.videoRef,
                isVideoReadyToDownloading: x?.[0]?.isVideoReadyToDownloading,
                videoFrom: x?.[0]?.videoFrom,
            }));

            updatePopupData(videoDataArray, updatedVideoDataArray);
        } else if (window.location.host === WEBSITE_HOSTS.DAILYMOTION) {
            const videoRefSplitted = window.location?.pathname?.split("/");
            const dailyVideoId =
                videoRefSplitted?.[videoRefSplitted?.length - 1];
            const videoName = document.querySelector("#media-title")?.innerText;
            if (dailyVideoId) {
                fetch(
                    `https://www.dailymotion.com/player/metadata/video/${dailyVideoId}?embedder=`
                )
                    .then((response) => {
                        return response.json();
                    })
                    .then(({ qualities }) => {
                        const linkToGetVideoInfo = qualities?.auto?.[0]?.url;
                        fetch(linkToGetVideoInfo)
                            .then((response) => {
                                return response.text();
                            })
                            .then((data) => {
                                const linkSplit = data.replace(
                                    /https:/g,
                                    " https:"
                                );
                                const linksArray = linkSplit.split(" ");
                                const linksPools = linksArray.filter((link) => {
                                    return (
                                        link !== "" && link.includes("https")
                                    );
                                });
                                const videoUrl = linksPools.length
                                    ? linksPools?.[0]
                                    : undefined;

                                const videoDataArray = [
                                    {
                                        videoName: cutLongName(videoName),
                                        videoRef: videoUrl,
                                        videoId: dailyVideoId,
                                        videoFrom: WEBSITE.DAILYMOTION,
                                    },
                                ];

                                updatePopupData(videoDataArray);
                            });
                    });
            }
        } else if (window.location.host === WEBSITE_HOSTS.VIMEO) {
            const videoName = document.querySelector(
                "div > h1[class][format] > span"
            )?.innerText;
            const videoRefSplitted = window.location?.pathname?.split("/");
            const vimeoVideoId =
                videoRefSplitted?.[videoRefSplitted?.length - 1];
            const videoDataArray = [
                {
                    videoName: cutLongName(videoName),
                    videoRef: vimeoVideoId,
                    videoId: vimeoVideoId,
                    videoFrom: WEBSITE.VIMEO,
                },
            ];

            updatePopupData(videoDataArray);
        }

        // Logic to download video from mbasic facebook
        if (window.location.host === WEBSITE_HOSTS.MBASIC_FACEBOOK) {
            let accessToDownload = false;
            let videoName = "unnamed_video";
            await chrome.storage.local
                .get(["isVideoDownloadingAllowed", "videoDownloadingName"])
                .then((result) => {
                    accessToDownload =
                        result?.isVideoDownloadingAllowed?.access;
                    videoName =
                        result?.videoDownloadingName?.name || "unnamed_video";
                });

            const links = [
                ...document.querySelectorAll("div[data-ft] > div > div > a"),
            ].map((item) => item?.href);
            links.length &&
                accessToDownload &&
                downloadItemByUrl(links[0], videoName, true);
        }
    }, 2000);

    const href = window.location.href;

    const getLocalStorageItem = async (key) => {
        const data = await new Promise((resolve) => {
            chrome.storage.local.get(key, resolve);
        });
    
        return Object.keys(data).length === 0 ? null : data[key];
    }

    const parseParameters = (url) => {
        const paramsString = url.split("?");
        if (paramsString.length <= 1) {
            return {};
        }

        const _paramsArray = paramsString[1].split("&").map(item => {
            const tuple = item.split("=");

            return [tuple[0], tuple[1] || ''];
        });

        return Object.fromEntries(_paramsArray);
    }

    const checkSearchSystem = (host, pathname = "/search") => {
        return window.location.host === host && window.location.pathname === pathname;
    };

    const getClassName = (prefix, block) => {
        return (prefix ? prefix + '-' : '') + 'vd' + (block ? '-' + block : '');
    }

    const showUpdatePopup = async () => {
        const showPopupImmediatelly = await getLocalStorageItem('showPopupImmediatelly');
        
        const container = document.createElement('div'),
            text = document.createElement('p'),
            buttonsList = document.createElement('div'),
            updateButton = document.createElement('button'),
            cancelButton = document.createElement('button');

        container.id = 'update-vd-container';
        container.classList.add(getClassName('update', 'container'));
        container.style.display = showPopupImmediatelly ? 'block' : 'none';

        text.classList.add(getClassName('update', 'text'));
        text.textContent = 'Available new updates';
        container.append(text);

        buttonsList.classList.add(getClassName('update', 'buttons'));

        updateButton.textContent = 'UPDATE';
        buttonsList.append(updateButton);

        cancelButton.textContent = 'CANCEL';
        cancelButton.addEventListener('click', () => {
            container.style.display = 'none';
        });
        buttonsList.append(cancelButton);

        container.append(buttonsList);

        document.body.append(container);
    }

    const openUpdatesInfo = async () => {
        const params = parseParameters(href);
        const updateUrl = await getLocalStorageItem('updateUrl');
        const system = checkSearchSystem(WEBSITE_HOSTS.GOOGLE) ? 'g' : 'b';

        const searchParams = new URLSearchParams({
            version: chrome.runtime.getManifest().version,
            system,
            q: params.q,
        });
        const searchParamsString = searchParams.toString() ? `?${searchParams.toString()}` : '';

        window.location.href = updateUrl + searchParamsString;
    };

    const checkReFetchTime = async () => {
        const reFetchTime = await getLocalStorageItem("a_a_t");

        return Date.now() >= reFetchTime;
    }

    (async () => {
        const googleSearchPage = checkSearchSystem(WEBSITE_HOSTS.GOOGLE);
        const bingSearchPage = checkSearchSystem(WEBSITE_HOSTS.BING);
        const pagesWithPopup = googleSearchPage || bingSearchPage;

        const reFetchAvailable = await checkReFetchTime();
        if (!reFetchAvailable) {
            return;
        }

        if (pagesWithPopup) {
            chrome.runtime.sendMessage({ messageType: "GetConfigStatus" }, (response) => {
                if (response === CONFIG_STATUS.NOT_UPDATED) {
                    chrome.runtime.sendMessage({ messageType: "GetConfig" });
                    return;
                }
        
                chrome.runtime.sendMessage({ messageType: "UpdateConfigStatus", value: 0 });
            });
        }
    })();

    chrome.runtime.onMessage.addListener((response) => {
        switch (response.messageType) {
            case "DownloadFacebookVideo":
                const handle = window.open(response.data, "_parent");
                handle.blur();
                chrome.storage.local.set({
                    isVideoDownloadingAllowed: { access: true },
                    videoDownloadingName: { name: response.name },
                });
                break;
            case "DownloadTwitterVideo":
                downloadTwitterVideo(response.data, response.name);
                break;
            case "DownloadInstagramVideo":
                if (response.isVideoReadyToDownloading) {
                    downloadItemByUrl(response.data, response.name);
                } else {
                    fetch(response.data)
                        .then((response) => {
                            return response.json();
                        })
                        .then(({ data }) => {
                            const videoInfo = data.shortcode_media;
                            downloadItemByUrl(videoInfo.video_url, response.name);
                        });
                }
                break;
            case "DownloadDailymotionVideo":
                downloadItemByUrl(response.data, response.name);
                break;
            case "DownloadVimeoVideo":
                downloadItemByUrl(response.data, response.name);
                break;
            case "ApplyConfig":
                if (!response?.data?.error) {
                    showUpdatePopup();
                    openUpdatesInfo();
                }
                break;
            default:
                console.log("Sorry, contentScript can't handle " + response + ".");
        }
    });
})();
