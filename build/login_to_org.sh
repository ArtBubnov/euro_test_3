echo -e "Logging into Salesforce Org\n"

echo "Global variables display"
echo "Target branch is:"
echo $TARGET_BRANCH_NAME

echo -e "\n\n\nCase logic execution logic to define salesforce org alias and internal variables has started..."
case $TARGET_BRANCH_NAME in
    "develop")
        CASE_LOG="qa"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_DELTAQA_SANDBOX
        SALESFORCE_ORG_ALIAS="salesforce_qa_sandbox.org"
        ;;
    "qa")
        CASE_LOG="qa"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_QA
        SALESFORCE_ORG_ALIAS="salesforce_qa.org"
        ;;
    "uat")
        CASE_LOG="uat"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_UAT
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

#previous version-----------------------------------
#echo "Login into Salesforce Org"

#cho "Create .key file"
#touch access_pass.key

#echo "Add access data to .key file"
#echo $ACCESS_KEY_SF_EINSTEINQA_SANDBOX > access_pass.key

#echo "Try Salesforce Org login"
#sfdx force:auth:sfdxurl:store -f "access_pass.key" -a salesforce_qa_sandbox.org -d