#! /bin/bash

set -x;
set -e;
# Set the OUTPUT name for AppImage to be the same as the BIN_PRO_RES_NAME
# Set the OUTPUT name for AppImage to be the same as the BIN_PRO_RES_NAME
export OUTPUT="${BIN_PRO_RES_NAME}";
# AppImageUpdate Informatoin
export VERBOSE=1;
export UPDATE_INFORMATION="gh-releases-zsync|${GITHUB_USERNAME}|${GITHUB_PROJECT}|continuous|${BIN_PRO_RES_NAME}-*x86_64.AppImage.zsync";
echo "UPDATE_INFORMATION=$UPDATE_INFORMATION";
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
function cleanup () 
{
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR"
    fi
}
trap cleanup EXIT;

# store repo root as variable
REPO_ROOT="$(readlink -f "$(dirname "$(dirname "$0")")")";
OLD_CWD="$(readlink -f .)";

# switch to build dir
pushd "$BUILD_DIR";

# configure build files with CMake
# we need to explicitly set the install prefix, as CMake's default is /usr/local for some reason...
cmake "$REPO_ROOT" -DCMAKE_INSTALL_PREFIX="/usr";

# build project and install files into AppDir
make -j"$(nproc)";
make install DESTDIR="AppDir";

# now, build AppImage using linuxdeploy and linuxdeploy-plugin-qt
# download linuxdeploy and its Qt plugin
wget -c -nv https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage;
wget -c -nv https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage;

# make them executable
chmod +x linuxdeploy*.AppImage;

# make sure Qt plugin finds QML sources so it can deploy the imported files
export "QML_SOURCES_PATHS=${REPO_ROOT}/src";

# initialize AppDir, bundle shared libraries for the QtQuickApp, 
# use Qt plugin to bundle additional resources, and build AppImage, all in one single command
./linuxdeploy-x86_64.AppImage --appdir "AppDir" --plugin qt --output appimage;

# move built AppImage back into original CWD
mv "${BIN_PRO_RES_NAME}"*.AppImage "$OLD_CWD";
################################ End of File ##################################
