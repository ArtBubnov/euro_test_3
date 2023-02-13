echo -e "Predeploy actions \n\n\n"

echo "Global variables display"
echo $EVENT_TYPE
echo $TARGET_BRANCH_NAME
echo $SOURCE_BRANCH_NAME


case $TARGET_BRANCH_NAME in
    "develop")
        CASE_LOG="qa"
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_qa_sandbox.org"
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
    echo "No changes in the directory force-app/main/default/profiles/ have been detected "
    echo "In this case only DIFF should be deployed on the target org"
    FILES_TO_DEPLOY=$(git diff --name-only ${DIFF_BRANCH} force-app | tr '\n' ',' | sed 's/\(.*\),/\1 /')
fi    

echo -e "\n\n\nFiles to deploy:"
echo $FILES_TO_DEPLOY

cd force-app/main/default/classes/tests

mapfile -t classes_files_array < <( ls )


COUNT=0
ARRAY_LEN=${#classes_files_array[@]}
LIST_OF_FILES_TO_TEST=""
LOOP_LEN=$( expr $ARRAY_LEN - 1)


echo "loop start"

while [ $COUNT -le $LOOP_LEN ]
do
    if [[ ${classes_files_array[$COUNT]} == *"Test.cls"* ]];
    then

        if [[ ${classes_files_array[$COUNT]} == *"cls-meta.xml"* ]];
        then
            LIST_OF_XML_FILES=$LIST_OF_XML_FILES{classes_files_array[$COUNT]}","
        else
            LEN_OF_FILE_NAME=${#classes_files_array[$COUNT]}
            NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_FILE_NAME - 4 )
            FILE_NAME_TRUNC=$((echo ${classes_files_array[$COUNT]}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )
            LIST_OF_FILES_TO_TEST=$LIST_OF_FILES_TO_TEST$FILE_NAME_TRUNC","
        fi

    fi 
    COUNT=$(( $COUNT +1))
done


LEN_OF_LIST_OF_FILES_TO_TEST=${#LIST_OF_FILES_TO_TEST}

NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_LIST_OF_FILES_TO_TEST - 1 )

LIST_OF_FILES_TO_TEST_TRUNC=$((echo ${LIST_OF_FILES_TO_TEST}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

echo "LIST_OF_FILES_TO_TEST"
echo $LIST_OF_FILES_TO_TEST_TRUNC

cd /home/circleci/project
git checkout $SOURCE_BRANCH_NAME


echo "Test deploy to Salesforce env without saving \n\n\n"
sfdx force:source:deploy -p $FILES_TO_DEPLOY -c -l RunSpecifiedTests -r $LIST_OF_FILES_TO_TEST_TRUNC -u $SALESFORCE_TARGET_ORG_ALIAS --loglevel WARN