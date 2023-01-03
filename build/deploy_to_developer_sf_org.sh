echo -e "Deploy data to Dev Env\n\n\n"

echo "variables test"

echo $EVENT_TYPE
echo $TARGET_BRANCH_NAME
echo $SOURCE_BRANCH_NAME

UPDATED_FILES=""

echo -e "\n\n\nSelect diff_file and Salesforce org alias"
case $TARGET_BRANCH_NAME in
    "dev")
        CASE_LOG="dev"
        DIFF_FILE_NAME="devdiff"
        SALESFORCE_ORG_ALIAS="salesforce_dev.org"
        ;;
    "qa")
        CASE_LOG="qa"
        DIFF_FILE_NAME="qadiff"
        SALESFORCE_ORG_ALIAS="salesforce_qa.org"
        ;;
    "uat")
        CASE_LOG="uat"
        DIFF_FILE_NAME="uatdiff"
        SALESFORCE_ORG_ALIAS="salesforce_uat.org"
        ;;
    "main")
        CASE_LOG="prod"
        DIFF_FILE_NAME="maindiff"
        SALESFORCE_ORG_ALIAS="salesforce_prod.org"
        ;;
    *)
        echo "Not valid"
        ;;
esac
echo $CASE_LOG
echo $DIFF_FILE_NAME
echo $SALESFORCE_ORG_ALIAS




echo -e "\n\n\nFind the difference between organizations"
PATH_FILTER="./"
UPDATED_FILES=$(git diff --name-only origin/dev force-app)
echo "What is the diff?"
echo $UPDATED_FILES

echo $UPDATED_FILES>>$DIFF_FILE_NAME.txt
echo -e "\n\n\nPlace diff data to a file"
mkdir /tmp/artifacts
echo -e $UPDATED_FILES | tr '\n' ',' | sed 's/\(.*\),/\1 /'>/tmp/artifacts/artifact-2

echo -e "\n\n\nRESUL TEST"
cat /tmp/artifacts/artifact-2


echo "Test deploy to Salesforce env without saving"
#sfdx force:source:deploy -p "$UPDATED_FILES" -c -l RunLocalTests -u salesforce_build.org --loglevel WARN
