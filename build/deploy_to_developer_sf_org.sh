echo -e "Deploy data to Dev Env\n\n\n"

echo -e "New tests\n\n\n"
echo "git log"
echo $(git log --oneline --no-decorate --merges qa)

getBranchPRInfo=$((git log --oneline --no-decorate --merges qa)| cut -d\  -f1)

#echo $(git log --oneline --no-decorate --merges qa)| cut -d\  -f1 > getBranchPRInfo

echo -e "ID IS"
echo $getBranchPRInfo


#echo $(git log --oneline qa) > gitLog.txt


#echo -e "Cat result"
#cat gitLog.txt


#echo "variables test"

#echo $EVENT_TYPE
#echo $TARGET_BRANCH_NAME
#echo $SOURCE_BRANCH_NAME

#UPDATED_FILES=""

#echo -e "\n\n\nSelect diff_file and Salesforce org alias"
#case $TARGET_BRANCH_NAME in
#    "dev")
#        CASE_LOG="dev"
#        DIFF_FILE_NAME="devdiff"
#        SALESFORCE_ORG_ALIAS="salesforce_dev.org"
#        ;;
#    "qa")
#        CASE_LOG="qa"
#        DIFF_FILE_NAME="qadiff"
#        SALESFORCE_ORG_ALIAS="salesforce_qa.org"
#        ;;
#    "uat")
#        CASE_LOG="uat"
#        DIFF_FILE_NAME="uatdiff"
#        SALESFORCE_ORG_ALIAS="salesforce_uat.org"
#        ;;
#    "main")
#        CASE_LOG="prod"
#        DIFF_FILE_NAME="maindiff"
#        SALESFORCE_ORG_ALIAS="salesforce_prod.org"
#        ;;
#    *)
#        echo "Not valid"
#        ;;
#esac
#echo $CASE_LOG
#echo $DIFF_FILE_NAME
#echo $SALESFORCE_ORG_ALIAS




#echo -e "\n\n\nFind the difference between organizations"
#PATH_FILTER="./"
#UPDATED_FILES=$(git diff --name-only origin/dev force-app)
#echo "What is the diff?"
#echo $UPDATED_FILES

#echo $UPDATED_FILES>>$DIFF_FILE_NAME.txt
#echo -e "\n\n\nPlace diff data to a file"
#mkdir /tmp/artifacts
#echo -e $UPDATED_FILES | tr '\n' ',' | sed 's/\(.*\),/\1 /'>/tmp/artifacts/artifact-2

#echo -e "\n\n\nRESUL TEST"
#cat /tmp/artifacts/artifact-2


#echo "Test deploy to Salesforce env \n\n\n"
#sfdx force:source:deploy -p "$UPDATED_FILES" -l RunLocalTests -u salesforce_build.org --loglevel WARN





#nstall_dependencies.sh------------*****************-----*-****-*-*-**-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
#This installs the sfdx cli

#echo "Installing Salesforce CLI"
#sudo npm install -global sfdx-cli

#echo "Salesforce CLI version check"
#sudo npm install sfdx --version








#login_to_org.sh------------*****************-----*-****-*-*-**-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
#echo "Logging into Salesforce Org"

#echo "Define Salesforce Org"
#echo $TARGET_BRANCH_NAME

#case $TARGET_BRANCH_NAME in
#    "dev")
#        CASE_LOG="dev"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_DEV
#        SALESFORCE_ORG_ALIAS="salesforce_dev.org"
#        ;;
#    "qa")
#        CASE_LOG="qa"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_QA
#        SALESFORCE_ORG_ALIAS="salesforce_qa.org"
#        ;;
#    "uat")
#        CASE_LOG="uat"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_UAT
#        SALESFORCE_ORG_ALIAS="salesforce_uat.org"
#        ;;
#    "main")
#        CASE_LOG="prod"
        #ACCESS_KEY_SF=$ACCESS_KEY_SF_PROD
#        SALESFORCE_ORG_ALIAS="salesforce_prod.org"
#        ;;
#    *)
#        echo "Not valid"
#        ;;
#esac

#echo "Salesforce org to be used:"
#echo $CASE_LOG
#echo "Salesforce alias to be used:"
#echo $SALESFORCE_ORG_ALIAS


#echo "Creating .key file"
#touch access_pass.key


#echo "Adding access data to .key file"
#echo $ACCESS_KEY_SF > access_pass.key


#echo "Try SF login"
#sfdx force:auth:sfdxurl:store -f "access_pass.key" -a $SALESFORCE_ORG_ALIAS -d
#sfdx force:org:display -u salesforce_test.org