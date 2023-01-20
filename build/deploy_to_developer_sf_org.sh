echo -e "Deploy data to Dev Env\n\n\n"


echo "Global variables display"
echo $EVENT_TYPE
echo $TARGET_BRANCH_NAME
echo $SOURCE_BRANCH_NAME


echo -e "\n\n\nSelect Salesforce org alias "
case $TARGET_BRANCH_NAME in
    "dev")
        CASE_LOG="dev"
        SALESFORCE_ORG_ALIAS="salesforce_dev.org"
        ;;
    "qa")
        CASE_LOG="qa"
        ORIGIN_BRANCH="qa"
        DIFF_BRANCH = "origin/dev"
        SALESFORCE_ORG_ALIAS="salesforce_qa.org"
        ;;
    "uat")
        CASE_LOG="uat"
        ORIGIN_BRANCH="uat"
        DIFF_BRANCH = "origin/qa"
        SALESFORCE_ORG_ALIAS="salesforce_uat.org"
        ;;
    "main")
        CASE_LOG="prod"
        ORIGIN_BRANCH="prod"
        DIFF_BRANCH = "origin/uat"
        SALESFORCE_ORG_ALIAS="salesforce_prod.org"
        ;;
    *)
        echo "Not valid"
        ;;
esac

echo e- "\n\n\nCase log display"
echo $CASE_LOG
echo $SALESFORCE_ORG_ALIAS


echo -e "\n\n\nFind the difference between organizations"

echo "Get git log"
echo $(git log --oneline --no-decorate --merges qa)
echo -e "\n\n\n"

echo -e "Git log cut logic execution"
cutPRLog=$((git log --oneline --no-decorate --merges qa)| cut -d\  -f1)
echo -e "Git log cut logic result\n"
echo $cutPRLog
echo -e "\n\n\n"

echo "Get current and previous pull request ID"
getcurrentPRid=$(echo $cutPRLog| cut -d\  -f1)
getpreviousPRid=$(echo $cutPRLog| cut -d\  -f2)

echo "getcurrentPRid"
echo $getcurrentPRid
echo "---------------"
echo "getpreviousPRid"
echo $getpreviousPRid


echo "Checkout to previous pull request"
git checkout $getpreviousPRid

echo -e "\n\n\n"

echo "Find diff"
GET_DIFF=$(git diff --name-only $DIFF_BRANCH force-app)

echo "Get back to origin branch"
git checkout $ORIGIN_BRANCH

echo "Deploy to Salesforce env \n\n\n"
sfdx force:source:deploy -p "$ORIGIN_BRANCH" -l RunLocalTests -u salesforce_build.org --loglevel WARN