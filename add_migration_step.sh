NEW_VERSION=${1:-9.9.9}
FOLDER=${2:-~/workspace/bonita-migration-sp}
echo "New migration step version will be: ${NEW_VERSION}\nTarget folder is: ${FOLDER}\nDo you confirm?\nPress Enter to continue or Ctrl-C to abort"

read unused

NEW_VERSION_UNDER=$(echo $NEW_VERSION | tr '.' '_')

perl -0777 -pi -e "s/(\n.*]\n.*ext\.overridedVersions)/,\n            '${NEW_VERSION}'\1/g" ${FOLDER}/community/build.gradle
perl -0777 -pi -e "s/(ext.overridedVersions.*\n\s*).*/\1'${NEW_VERSION}': '${NEW_VERSION}-SNAPSHOT'/" ${FOLDER}/community/build.gradle

perl -0777 -pi -e "s/('[^,].*$)/\1,\n        'migrateTo_${NEW_VERSION_UNDER}'/" ${FOLDER}/community/settings.gradle

perl -0777 -pi -e "s/(\n.*]\n.*ext\.overridedVersions)/,\n            '${NEW_VERSION}'\1/g" ${FOLDER}/subscription/build.gradle
perl -0777 -pi -e "s/(ext.overridedVersions.*\n\s*).*/\1'${NEW_VERSION}': '${NEW_VERSION}-SNAPSHOT'/" ${FOLDER}/subscription/build.gradle

perl -0777 -pi -e "s/('[^,].*$)/\1,\n        'migrateToSP_${NEW_VERSION_UNDER}'/" ${FOLDER}/subscription/settings.gradle

for f in `find . -name "*.groovy"`
do
	new_name=$(echo $f | sed -e "s/NEW_VERSION/${NEW_VERSION_UNDER}/g")
	mkdir -p $(dirname ${FOLDER}/${new_name})
	cp $f ${FOLDER}/${new_name}
done

find ${FOLDER} -name "*.groovy" | xargs sed -i -e "s/NEW_VERSION/${NEW_VERSION_UNDER}/g"

echo "================== WARNING ======================="
echo "It is assumed that no SP-specific step is required"
echo "If this is not the case, add manually the migration step for SP in:"
echo "subscription/bonita-migration-distrib-sp/src/main/groovy/com/bonitasoft/migration/version"
echo " + tests"
echo "================== WARNING ======================="