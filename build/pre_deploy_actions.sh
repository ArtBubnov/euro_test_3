echo -e "Predeploy actions \n\n\n"

echo "Global variables display"
echo $EVENT_TYPE
echo $TARGET_BRANCH_NAME
echo $SOURCE_BRANCH_NAME


echo "Rin apex tests \n\n\n"
sfdx force:apex:test:run -l RunLocalTests -d $SOURCE_BRANCH_NAME/force-app -u me@my.org

echo "Test deploy to Salesforce env without saving \n\n\n"
sfdx force:source:deploy -p $TARGET_BRANCH_NAME/force-app -c -l RunLocalTests -u salesforce_build.org --loglevel WARN