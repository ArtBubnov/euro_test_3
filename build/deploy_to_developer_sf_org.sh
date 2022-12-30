echo "Deploy data to Dev Env"

echo "variables test"

echo $EVENT_TYPE
echo $TARGET_BRANCH_NAME
echo $SOURCE_BRANCH_NAME






echo "Find the difference between organizations"
PATH_FILTER="./"
UPDATED_FILES=$(git diff --name-only origin/qa force-app)
echo "What is the diff?"
echo $UPDATED_FILES


echo "Test deploy to Salesforce env without saving"
#sfdx force:source:deploy -p "$UPDATED_FILES" -c -l RunLocalTests -u salesforce_build.org --loglevel WARN



#sfdx force:source:deploy -p force-app -c -l RunLocalTests -u salesforce_test.org --loglevel WARN