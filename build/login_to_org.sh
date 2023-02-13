echo -e "Logging into Salesforce Org\n"

echo "Global variables display:"
echo "Target branch is:"
echo $TARGET_BRANCH_NAME

echo -e "\n\n\nCase logic execution to define salesforce org alias and internal variables has started..."
case $TARGET_BRANCH_NAME in
    "develop")
        CASE_LOG="qa"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_DELTAQA_SANDBOX
        SALESFORCE_ORG_ALIAS="salesforce_qa_sandbox.org"
        ;;
    "uat")
        CASE_LOG="uat"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_EINSTEINUAT_SANDBOX
        SALESFORCE_ORG_ALIAS="salesforce_uat.org"
        ;;
    "main")
        CASE_LOG="prod"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_PROD
        SALESFORCE_ORG_ALIAS="salesforce_prod.org"
        ;;
    *)
        echo "Not valid"
        ;;
esac

echo "..."
echo "..."
echo "..."
echo "Case logic execution results:"
echo "Case result:"
echo $CASE_LOG
echo "Salesforce org to be used:"
echo $CASE_LOG
echo "Salesforce alias to be used:"
echo $SALESFORCE_ORG_ALIAS


echo -e "\n\n\nCreating .key file"
touch access_pass.key


echo -e "\n\n\nAdding access data to .key file"
echo $ACCESS_KEY_SF > access_pass.key

echo "Try SF login"
sfdx force:auth:sfdxurl:store -f "access_pass.key" -a ${SALESFORCE_ORG_ALIAS} -d