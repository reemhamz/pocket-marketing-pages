#!/usr/bin/env bash
set -uo pipefail
set -x

mkdir -vp content/marketing-assets
pushd content

# LANGS="en,en de,de-DE es,es-ES es-LA,es fr,fr-FR fr-CA,fr it,it-IT ja,ja-JP ko,ko-KR nl,nl-NL pl,pl-PL pt,pt-PT pt-BR,pt ru,ru-RU zh-CN zh-TW"

# PAGES="""
# https://getpocket.com/save-to-pocket/
# https://getpocket.com/pocket-and-firefox/
# https://getpocket.com/about/
# https://getpocket.com/explore/pocket-hits-signup/
# https://getpocket.com/pocket-hits/confirmation/
# https://getpocket.com/privacy/
# https://getpocket.com/tos/
# https://getpocket.com/contact-info/
# https://getpocket.com/jobs/
# https://getpocket.com/firefox/new_tab_learn_more/
# https://getpocket.com/welcome/
# https://getpocket.com/chrome/
# https://getpocket.com/safari/
# https://getpocket.com/android/
# https://getpocket.com/ios/
# https://getpocket.com/edge/
# https://getpocket.com/opera/
# https://getpocket.com/add/
# """

# # Extra (  ) needed for sed matching
# EXTRA_ASSETS="""
# https://getpocket.com(/i/apple-touch-icon/Pocket_AppIcon_@114.png)
# https://getpocket.com(/i/apple-touch-icon/Pocket_AppIcon_@144.png)
# https://getpocket.com(/i/apple-touch-icon/Pocket_AppIcon_@57.png)
# https://getpocket.com(/i/apple-touch-icon/Pocket_AppIcon_@72.png)
# """

# COOKIE="""<!-- OneTrust Cookies Consent Notice start for getpocket.com --> <script type='text/javascript' src='https://cdn.cookielaw.org/consent/a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/OtAutoBlock.js' ></script> <script src='https://cdn.cookielaw.org/consent/a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/otSDKStub.js'  type='text/javascript' charset='UTF-8' data-domain-script='a7ff9c31-9f59-421f-9a8e-49b11a3eb24e' ></script> <script type='text/javascript'> function OptanonWrapper() { } </script> <!-- OneTrust Cookies Consent Notice end for getpocket.com --> """

# for lang in ${LANGS};
# do
#     short_lang=$(echo ${lang} | cut -d , -f 1)
#     long_lang=$(echo ${lang} | cut -d , -f 2)

#     mkdir -vp ${short_lang}
#     pushd ${short_lang}

#     # Copy assets from global assets to avoid re-downloading and speedup mirroring

#     cp -R ../marketing-assets/. .


#     for page in ${PAGES};
#     do
#         cut_dirs=0
#         if [[ $page == https://getpocket.com/about/ ]];
#         then
#             page="https://getpocket.com/${long_lang}/about/"
#             cut_dirs=1
#         fi

#         wget --timestamping \
#              --quiet\
#              --header="Accept-Language: ${lang}" \
#              -l 0 \
#              -e robots=off \
#              --cut-dirs=${cut_dirs} \
#              -nH -H -p -k --adjust-extension \
#              ${page}
#     done

#     # Copy assets back to global assets (some locales have more assets than others)
#     # do that in a loop because not all assets exist in all locales
#     for dir in img i j *.js web web-discover web-ui _next assets;
#     do
#  	    cp -R "${dir}" ../marketing-assets/;
#     done
# 	rm -rf img i j *.js web web-discover web-ui _next assets a7ff9c31-9f59-421f-9a8e-49b11a3eb24e

#     popd
# done


# # Get assets not processed by wget
# pushd marketing-assets
# for extra_asset in ${EXTRA_ASSETS};
# do
#     url=$(echo ${extra_asset} | tr -d "\(\)")
#     wget --mirror -nH ${url}
#     find . -type f -exec sed -i -r "s|${extra_asset}|/marketing-assets\1|" {} \;
# done
# popd

# # Remove current cookie consent
# find . -name consent -type d -exec rm -rf {} \;
# find . -name \*.html -exec sed -i -s 's|<script type="text/javascript" src="../a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/OtAutoBlock.js"></script><script src="../a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/otSDKStub.js" type="text/javascript" charSet="UTF-8" data-domain-script="a7ff9c31-9f59-421f-9a8e-49b11a3eb24e"></script><script>function OptanonWrapper() { }</script>||' {} \;
# find . -name \*.html -exec sed -i -s 's|<script type="text/javascript" src="../consent/a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/OtAutoBlock.js"></script><script src="../consent/a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/otSDKStub.js" type="text/javascript" charSet="UTF-8" data-domain-script="a7ff9c31-9f59-421f-9a8e-49b11a3eb24e"></script><script>function OptanonWrapper() { }</script>||' {} \;
# find . -name \*.html -exec sed -i -s 's|<script type="text/javascript" src="../../consent/a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/OtAutoBlock.js"></script><script src="../../consent/a7ff9c31-9f59-421f-9a8e-49b11a3eb24e/otSDKStub.js" type="text/javascript" charSet="UTF-8" data-domain-script="a7ff9c31-9f59-421f-9a8e-49b11a3eb24e"></script><script>function OptanonWrapper() { }</script>||' {} \;
# find . -name \*.html -exec sed -i '/<!-- OneTrust Cookies Consent Notice start for getpocket.com/,/OneTrust Cookies Consent Notice end for getpocket.com -->/d' {} \;
# # Add cookie consent
# find . -name \*.html -exec sed -i -s "s|</title>|</title>\n${COOKIE}|" {} \;

prettier.sh --write .


# Fix assets
find . -name \*.html -exec sed -i  's/"\/i\/v4\//"\/marketing-assets\/\i\/v4\//g' {} \;
find . -name \*.html -exec sed -i  's/ \/i\/v4\// \/marketing-assets\/\i\/v4\//g' {} \;
find . -name \*.html -exec sed -i  's/\.\.\//\/marketing-assets\//g' {} \;
find . -name \*.html -exec sed -s -i  's|marketing-assets\/\/marketing-assets|marketing-assets|g' {} \;
for file in $(find . -type f -name \*\\?\*);
do
    mv "${file}" "${file%\?*}"
done

for file in $(find . -type f -name \*.html -o -name \*.css);
do
    sed -i -r 's|%3F.*?"|"|' ./en/welcome/index.html "${file}"
done


# Set canonical URLs
for file in $(find . -name index.html);
do
    url_path=$(echo ${file} | cut -d '/' -f 2,3)
    sed -i -r 's|</head>|<link rel="canonical" href="https://www.getpocket.com/'"${url_path}"'/">\n</head>|' "${file}"
done

popd
