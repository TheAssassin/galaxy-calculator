#! /bin/bash
# Last Update: 17 April 2020
# replace the ? in shell check
# cd /mnt/qnap-light-wizzard/workspace/GalaticCalculator/Galaxy-Calculator/tools; shell?check -x build-with-qmake.sh
ls; 
set -x;
set -e;
# Set the OUTPUT name for AppImage to be the same as the BIN_PRO_RES_NAME
export OUTPUT="${BIN_PRO_RES_NAME}.AppImage";
# AppImageUpdate Informatoin
export VERBOSE=1;
export UPDATE_INFORMATION="gh-releases-zsync|${GITHUB_USERNAME}|${GITHUB_PROJECT}|continuous|${BIN_PRO_RES_NAME}-*x86_64.AppImage.zsync";
echo "UPDATE_INFORMATION=$UPDATE_INFORMATION";
#export UPDATE_INFORMATION="zsync|https://github.com/${GITHUB_USERNAME}/${GITHUB_PROJECT}/releases/download/continuous/${BIN_PRO_RES_NAME}-x86_64.AppImage.zsync";
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
REPO_ROOT="$(readlink -f "$(dirname "$(dirname "$0")")")";
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
make -j"$(nproc)";
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
echo "Completed LinuxDeploy"
ls;
# move built AppImage back into original CWD
if [ -f "${BIN_PRO_RES_NAME}".AppImage ]; then
    echo "Found ${BIN_PRO_RES_NAME}.AppImage"
    chmod +x "${BIN_PRO_RES_NAME}.AppImage";
    mv "${BIN_PRO_RES_NAME}.AppImage" "${OLD_CWD}";
fi
if [ -f "${BIN_PRO_RES_NAME}".AppImage.zsync ]; then
    echo "Found ${BIN_PRO_RES_NAME}.AppImage.zsync"
    chmod +x "${BIN_PRO_RES_NAME}.AppImage.zsync";
    mv "${BIN_PRO_RES_NAME}.AppImage.zsync" "${OLD_CWD}";
fi
popd;

ls;
#
echo "Running Qt Installer Framework";

mkdir -pv qtinstallerframework;
7z e "${QIF_ARCHIVE}" -o./qtinstallerframework;
ls;
ls -lh qtinstallerframework/; 
chmod -R +x ./qtinstallerframework;
cp -v "${BIN_PRO_RES_NAME}.AppImage" "${QIF_PACKAGE_DATA}";
cp -v "${BIN_PRO_RES_NAME}.AppImage.zsync" "${QIF_PACKAGE_DATA}";
# cp -v "resources/Galaxy-Calculator.desktop" "${QIF_PACKAGE_DATA}";
cp -v "resources/Galaxy-Calculator.png" "${QIF_PACKAGE_DATA}";
cp -v "resources/Galaxy-Calculator.svg" "${QIF_PACKAGE_DATA}";
cp -v "resources/Galaxy-Calculator.ico" "${QIF_PACKAGE_DATA}";

rsync -a "usr/share/icons" "${QIF_PACKAGE_DATA}/icons";

echo "Running Qt Installer Framework";
# Note that this is only for building the Qt IF file, it does not ship with this qtaccount.ini
# Windows
# "C:/Users/%USERNAME%/AppData/Roaming/Qt/qtlicenses.ini"
# "C:/Users/%USERNAME%/AppData/Roaming/Qt/qtaccount.ini"
# Linux
# "/home/$USERNAME/.local/share/Qt/qtlicenses.ini"
# "/home/$USERNAME/.local/share/Qt/qtaccount.ini"
# OS X
# "/Users/$USERNAME/Library/Application Support/Qt/qtlicenses.ini"
# "/Users/$USERNAME/Library/Application Support/Qt/qtaccount.ini"
if [ -n "${QT_EMAIL}" ]; then printf "[QtAccount]\nemail=%s\njwt=%s\nu=%s" "${QT_EMAIL}" "${QT_JWT}" "${QT_U}" > qtaccount.ini; fi;
./qtinstallerframework/binarycreator -c config/config.xml -p packages "${ARTIFACT_QIF}";
# remove this file now for security: Note that these Values are stored in Travis Environment Variables, and the credential part is encrypted to begin with
if [ -n "${QT_EMAIL}" ]; then rm -f qtaccount.ini; fi;
ls;
echo "Completed build-with-qmake.sh";
################################ End of File ##################################

