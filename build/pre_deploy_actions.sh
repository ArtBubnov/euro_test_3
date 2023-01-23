echo -e "Predeploy actions \n\n\n"

echo "Global variables display"
echo $EVENT_TYPE
echo $TARGET_BRANCH_NAME
echo $SOURCE_BRANCH_NAME


case $TARGET_BRANCH_NAME in
    "dev")
        CASE_LOG="dev"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_DEV
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_dev.org"
        ;;
    "qa")
        CASE_LOG="qa"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_QA
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_qa.org"
        ;;
    "uat")
        CASE_LOG="uat"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_UAT
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_uat.org"
        ;;
    "main")
        CASE_LOG="prod"
        ACCESS_KEY_SF=$ACCESS_KEY_SF_PROD
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_prod.org"
        ;;
    *)
        echo "Not valid"
        ;;
esac

echo "Salesforce org to be used:"
echo $CASE_LOG
echo "Salesforce alias to be used:"
echo $SALESFORCE_ORG_ALIAS







#echo "Rin apex tests \n\n\n"
#sfdx force:apex:test:run -l RunLocalTests -d ${SOURCE_BRANCH_NAME}/force-app -u $SALESFORCE_ORG_ALIAS

echo "Test deploy to Salesforce env without saving \n\n\n"
sfdx force:source:deploy -p $TARGET_BRANCH_NAME/force-app -c -l RunLocalTests -u $SALESFORCE_ORG_ALIAS --loglevel WARN