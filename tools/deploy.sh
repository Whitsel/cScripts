#!/bin/bash

set -e

VERSION_TAG=$*

mkdir release/

sed -i "s/#define VERSION.*/#define VERSION \"${VERSION_TAG}\"/" cScripts/script_component.hpp
sed -i "s/DevBuild/${VERSION_TAG}/" tools/config.json

python3 tools/build.py --deploy

# Special Builds
python3 tools/build.py --build config_debug.json --deploy
python3 tools/build.py --build config_noLoadouts.json --deploy
python3 tools/build.py --build config_noACRE.json --deploy

sed -i "s/DEVBUILD/${VERSION_TAG}/g" Compositions/*/header.sqe

# Make a patch release
set +e # allow fail
PREV_TAG=$(git describe --abbrev=0 --tags `git rev-list --tags --skip=1 --max-count=1`)
echo "Creating patch build for ${PREV_TAG} to ${VERSION_TAG}"
git diff --name-only ${PREV_TAG} ${VERSION_TAG} > pre_changed_file_list.txt
sed '/tools/d;/Compositions/d;/resourses/d;/^\.\(.*\)/d' pre_changed_file_list.txt > changed_file_list.txt
zip release/cScripts_PATCH_v${PREV_TAG}_to_v${VERSION_TAG}.zip -@ < changed_file_list.txt
set -e

# Pack Compositions
zip release/Compositions-${VERSION_TAG}.zip -r Compositions

# Disabled
#chmod +x ./tools/build_settings_config.sh
#./tools/build_settings_config.sh $VERSION_TAG