echo -e "Deploy data to Dev Env logic execution has started ..."


echo "Global variables display"
echo "Event type is:"
echo $EVENT_TYPE
echo "Target branch is:"
echo $TARGET_BRANCH_NAME


echo -e "\n\n\nCase logic execution logic to define salesforce org alias and internal variables has started..."
case $TARGET_BRANCH_NAME in
    "dev")
        CASE_LOG="dev"
        SALESFORCE_ORG_ALIAS="salesforce_dev.org"
        ;;
    "qa")
        CASE_LOG="qa"
        ORIGIN_BRANCH="qa"
        DIFF_BRANCH="origin/dev"
        SALESFORCE_ORG_ALIAS="salesforce_qa.org"
        ;;
    "uat")
        CASE_LOG="uat"
        ORIGIN_BRANCH="uat"
        DIFF_BRANCH="origin/qa"
        SALESFORCE_ORG_ALIAS="salesforce_uat.org"
        ;;
    "main")
        CASE_LOG="prod"
        ORIGIN_BRANCH="prod"
        DIFF_BRANCH="origin/uat"
        SALESFORCE_ORG_ALIAS="salesforce_prod.org"
        ;;
    *)
        echo "Not valid"
        ;;
esac

echo "..."
echo "..."
echo "..."
echo -e "Case logic execution results:"
echo "Case result"
echo $CASE_LOG
echo "Origin branch is:"
echo $ORIGIN_BRANCH
echo "Name of the branch to find diff is:"
echo $DIFF_BRANCH
echo "Salesforce org alias is:"
echo $SALESFORCE_ORG_ALIAS


echo -e "\n\n\nFind the difference between organizations"

echo "Get git log"
echo $(git log --oneline --no-decorate --merges ${TARGET_BRANCH_NAME})
echo -e "\n\n\n"

echo -e "Git log cut logic execution"
cutPRLog=$((git log --oneline --no-decorate --merges ${TARGET_BRANCH_NAME})| cut -d\  -f1)

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


echo -e "\n\n\nCheckout to previous pull request"
git checkout $getpreviousPRid

echo -e "\n\n\n"

echo "Diff logic execution result"
GET_DIFF=$(git diff --name-only $DIFF_BRANCH force-app)

echo -e "\n\n\nGet back to origin branch"
git checkout $ORIGIN_BRANCH

#echo "Deploy to Salesforce env \n\n\n"
#sfdx force:source:deploy -p "$ORIGIN_BRANCH" -l RunLocalTests -u salesforce_build.org --loglevel WARN