#! /bin/bash
ls; 
set -x;
set -e;
# Set the OUTPUT name for AppImage to be the same as the BIN_PRO_RES_NAME
OUTPUT="${BIN_PRO_RES_NAME}";
# AppImageUpdate Informatoin
export UPDATE_INFORMATION="gh-releases-zsync|${GITHUB_USERNAME}|${GITHUB_PROJECT}|continuous|${BIN_PRO_RES_NAME}-*x86_64.AppImage.zsync";
# building in temporary directory to keep system clean
# use RAM disk if possible (as in: not building on CI system like Travis, and RAM disk is available)
if [ "$CI" == "" ] && [ -d "/dev/shm" ]; then
    TEMP_BASE="/dev/shm";
else
    TEMP_BASE="/tmp";
fi
# Make Build Directory
BUILD_DIR="$(mktemp -d -p "$TEMP_BASE" "${BIN_PRO_RES_NAME}-build-XXXXXX")";

# make sure to clean up build dir, even if errors occur
function cleanup() 
{
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR"
    fi
}
trap cleanup EXIT

# store repo root as variable
REPO_ROOT="$(readlink -f $(dirname $(dirname $0)))";
OLD_CWD="$(readlink -f .)";

echo "REPO_ROOT=$REPO_ROOT";
echo "OLD_CWD=$OLD_CWD";
# switch to build dir
pushd "$BUILD_DIR";

# configure build files with qmake
# we need to explicitly set the install prefix, as CMake's default is /usr/local for some reason...
#qmake -makefile "${REPO_ROOT}/${BIN_PRO_RES_NAME}.pro";
qmake -makefile "${REPO_ROOT}";

# build project and install files into AppDir
make -j$(nproc);
make install INSTALL_ROOT="AppDir";
echo "Downloading AppImage";
# now, build AppImage using linuxdeploy and linuxdeploy-plugin-qt
# download linuxdeploy and its Qt plugin
wget -c -nv "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage";
wget -c -nv "https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage";
# make them executable
chmod +x linuxdeploy*.AppImage;
# make sure Qt plugin finds QML sources so it can deploy the imported files
export QML_SOURCES_PATHS="${REPO_ROOT}/src";
echo "QML_SOURCES_PATHS=${QML_SOURCES_PATHS}";
echo "-d ${REPO_ROOT}/resources/${BIN_PRO_RES_NAME}.desktop";
ls "${REPO_ROOT}/resources";
# QtQuickApp does support "make install", but we don't use it because we want to show the manual packaging approach in this example
# initialize AppDir, bundle shared libraries, add desktop file and icon, use Qt plugin to bundle additional resources, and build AppImage, all in one command
./linuxdeploy-x86_64.AppImage --appdir "AppDir" -e "${BIN_PRO_RES_NAME}" -i "${REPO_ROOT}/resources/${BIN_PRO_RES_NAME}.png" -d "${REPO_ROOT}/resources/${BIN_PRO_RES_NAME}.desktop" --plugin qt --output appimage;
ls;
# move built AppImage back into original CWD
mv ${BIN_PRO_RES_NAME}*.AppImage "${OLD_CWD}";
popd;
ls;
#
mkdir -vp "/usr/share/doc/libc6";
#cp -rv "/usr/share/doc/libc6/copyright" "usr/share/doc/libc6/copyright";
ls "/usr/share/doc/libc6/copyright";
ls "usr/share/doc/libc6/copyright";
echo "Running Qt Installer";
if [ ! -z "QT_EMAIL" ]; then echo "[General]\nemail=${QT_EMAIL}\n[QtAccount]\nemail=${QT_EMAIL}\njwt=${QT_JWT}\nu=${QT_U}" > qtaccount.ini; fi;
7z e "tools/qtinstallerframework.7z"
ls;
export ARTIFACT_GCI="${BIN_PRO_RES_NAME}-Installer";
./qtinstallerframework/binarycreator -c config/config.xml -p packages "${ARTIFACT_GCI}";
ls;
echo "Completed build-with-qmake.sh";
################################ End of File ##################################

