echo -e "Predeploy actions \n\n\n"

echo "Global variables display"
echo $EVENT_TYPE
echo $TARGET_BRANCH_NAME
echo $SOURCE_BRANCH_NAME


case $TARGET_BRANCH_NAME in
    "dev")
        CASE_LOG="dev"
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_dev.org"
        ;;
    "qa")
        CASE_LOG="qa"
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_qa.org"
        ;;
    "uat")
        CASE_LOG="uat"
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_uat.org"
        ;;
    "main")
        CASE_LOG="prod"
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_prod.org"
        ;;
    *)
        echo "Not valid"
        ;;
esac

echo -e "\n\n\nSalesforce org to be used:"
echo $CASE_LOG
echo "Salesforce alias to be used:"
#echo $SALESFORCE_ORG_ALIAS


echo -e "\n\n\nFind the difference between organizations"
DIFF_BRANCH="origin/"$SOURCE_BRANCH_NAME
echo "Diff logic execution result:"
GET_DIFF=$(git diff --name-only ${DIFF_BRANCH} force-app)
echo $GET_DIFF
echo -e "\n\n\n"

if [[ $GET_DIFF == *"/profiles/"* ]];
then
    echo "Changes in the directory force-app/main/default/profiles/ have been detected"
    echo "In this case all files in force-app should be deployed on the target org"
    FILES_TO_DEPLOY="force-app/main/default"
else
    echo "No changes in the directory force-app/main/default/profiles/ have been detected"
    echo "In this case only DIFF should be deployed on the target org"
    FILES_TO_DEPLOY=$(git diff --name-only ${DIFF_BRANCH} force-app | tr '\n' ',' | sed 's/\(.*\),/\1 /')
fi    

echo -e "\n\n\nFiles to deploy:"
echo $FILES_TO_DEPLOY

echo "Test deploy to Salesforce env without saving \n\n\n"
sfdx force:source:deploy -p $FILES_TO_DEPLOY -c -l RunLocalTests -u $SALESFORCE_ORG_ALIAS --loglevel WARN