echo "Logging into Salesforce Org"

echo "Define Salesforce Org"
echo $TARGET_BRANCH_NAME

case $TARGET_BRANCH_NAME in
    "dev")
        CASE_LOG="dev"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_DEV
        SALESFORCE_ORG_ALIAS="salesforce_dev.org"
        ;;
    "qa")
        CASE_LOG="qa"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_QA
        SALESFORCE_ORG_ALIAS="salesforce_qa.org"
        ;;
    "uat")
        CASE_LOG="uat"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_UAT
        SALESFORCE_ORG_ALIAS="salesforce_uat.org"
        ;;
    "main")
        CASE_LOG="prod"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_PROD
        SALESFORCE_ORG_ALIAS="salesforce_prod.org"
        ;;
    *)
        echo "Not valid"
        ;;
esac

echo "Salesforce org to be used:"
echo $CASE_LOG
echo "Salesforce alias to be used:"
echo $SALESFORCE_ORG_ALIAS


#echo "Creating .key file"
#touch access_pass.key


#echo "Adding access data to .key file"
#echo $ACCESS_KEY_SF > access_pass.key


#echo "Try SF login"
#sfdx force:auth:sfdxurl:store -f "access_pass.key" -a $SALESFORCE_ORG_ALIAS -d
#sfdx force:org:display -u salesforce_test.org








      #- touch access_pass.key
      #- echo $accessKeySF > access_pass.key

      #Salesfrce org auth
      #- sfdx force:auth:sfdxurl:store -f "access_pass.key" -a salesforce_test.org -d
      #- sfdx force:org:display -u salesforce_test.org