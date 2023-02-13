echo -e "Predeploy actions \n\n\n"

echo "Global variables display:"
echo "Event type is:"
echo $EVENT_TYPE
echo "Target branch name is:"
echo $TARGET_BRANCH_NAME
echo "Source branch name is:"
echo $SOURCE_BRANCH_NAME


echo "@@@@@@@@@@@@@@@@@@"
pwd
ls -a
echo "@@@@@@@@@@@@@@@@@@"

echo -e "\n\n\nCase logic execution to define salesforce org alias and internal variables has started..."
case $TARGET_BRANCH_NAME in
    "develop")
        CASE_LOG="qa"
        SALESFORCE_TARGET_ORG_ALIAS="salesforce_qa_sandbox.org"
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

echo "..."
echo "..."
echo "..."
echo "Case logic execution results:"
echo "Case result:"
echo $CASE_LOG
echo "Salesforce alias to be used:"
echo $SALESFORCE_TARGET_ORG_ALIAS




echo -e "\n\n\nCase logic execution to define the list of files to be deployed to the Salesforce org..."
case $CASE_LOG in
    "develop")
        echo -e "\n\n\nFind the difference between organizations"
        DIFF_BRANCH="origin/"$SOURCE_BRANCH_NAME

        echo "Diff logic execution result:"
        GET_DIFF=$(git diff --name-only ${DIFF_BRANCH} force-app)
        echo $GET_DIFF

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
        ;;
    "uat")
        FILES_TO_DEPLOY="force-app/main/default"
        ;;
    "main")
        FILES_TO_DEPLOY="force-app/main/default"
        ;;
    *)
        echo "Not valid"
        ;;
esac

echo -e "\n\n\nFiles to deploy:"
echo $FILES_TO_DEPLOY



#get to classes directory to define the list of tests to be executed
cd force-app/main/default/classes/tests

#add all the files in the folder into array
mapfile -t classes_files_array < <( ls )

#define which of the files are tests
COUNT=0
ARRAY_LEN=${#classes_files_array[@]}
LIST_OF_FILES_TO_TEST=""
LOOP_LEN=$( expr $ARRAY_LEN - 1)


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

echo -e "\n\n\nList of files to test\n\n\n"
echo $LIST_OF_FILES_TO_TEST_TRUNC

#get back to the root directory
cd /home/circleci/project
git checkout $SOURCE_BRANCH_NAME


echo -e "\n\n\nOutput list of files to be deployed logic execution"


echo "@@@@@@@@@@@@@@@@@@@@@@@@@@"
#test. delete
FILES_TO_DEPLOY="force-app/main/default"
#test. delete
echo "loop start"
if [[ $FILES_TO_DEPLOY == *"force-app/main/default"* ]];
then
#-------------------TRUE logic start------------------------------------
    echo "TRUE"
    cd force-app/main/default
    mapfile -t forceapp_files_array < <( ls )
    LOOP_ROOT_DIR="/home/circleci/project/force-app/main/default"

    COUNT=0
    ARRAY_LEN=${#forceapp_files_array[@]}
    LIST_OF_FILES_TO_TEST=""
    LOOP_LEN=$( expr $ARRAY_LEN - 1)


    while [ $COUNT -le $LOOP_LEN ]
    do
        cd ${forceapp_files_array[$COUNT]}
        echo -e "\n\n\nLOOP STEP START"
        echo -e "\nName of the folder"
        echo ${forceapp_files_array[$COUNT]}
        echo -e "\nWhat is in the foleder"
        ls
        echo -e"\nGet back to force-app/main/default"
        cd $LOOP_ROOT_DIR
        ls
        echo -e "\nLOOP STEP END\n\n\n"
        #if [[ -d directory/ ]];
        #then
        #else
        #fi 
        #COUNT=$(( $COUNT +1))
    done
#-------------------TRUE logic start------------------------------------
else
    echo "FALSE"
fi
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@"


echo "Test deploy to Salesforce env without saving \n\n\n"
#sfdx force:source:deploy -p ${FILES_TO_DEPLOY} -c -l RunSpecifiedTests -r ${LIST_OF_FILES_TO_TEST_TRUNC} -u ${SALESFORCE_TARGET_ORG_ALIAS} --loglevel WARN