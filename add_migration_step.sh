NEW_VERSION=${1:-9.9.9}
FOLDER=${2:-~/workspace/bonita-migration-sp}
echo "New migration step version will be: ${NEW_VERSION}\nTarget folder is: ${FOLDER}\nDo you confirm?\nPress Ctrl-C to abort or Enter to continue"
read unused

cp -R community ${FOLDER}
cp -R subscription ${FOLDER}

perl -0777 -pi -e 's/(\n.*]\n.*ext\.overridedVersions)/,\n            ${NEW_VERSION}\1/g' ${FOLDER}/community/build.gradle
perl -pi -e 's/(\s):.*$/\1${NEW_VERSION}:${NEW_VERSION}-SNAPSHOT/' ${FOLDER}/community/build.gradle

perl -0777 -pi -e "s/'\n\s*$/',\n        'NEW_VERSION'\1/g" ${FOLDER}/community/settings.gradle

perl -0777 -pi -e 's/(\n.*]\n.*ext\.overridedVersions)/,\n            ${NEW_VERSION}\1/g' ${FOLDER}/subscription/build.gradle
perl -pi -e 's/(\s):.*$/\1${NEW_VERSION}:${NEW_VERSION}-SNAPSHOT/' ${FOLDER}/subscription/build.gradle

perl -0777 -pi -e "s/'\n\s*$/',\n        'NEW_VERSION'\1/g" ${FOLDER}/subscription/settings.gradle



echo "================== WARNING ======================="
echo "It is assumed that no SP-specific step is required"
echo "If this is not the case, add manually the migration step for SP in:"
echo "subscription/bonita-migration-distrib-sp/src/main/groovy/com/bonitasoft/migration/version"
echo " + tests"
echo "================== WARNING ======================="