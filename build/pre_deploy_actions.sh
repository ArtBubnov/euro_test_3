echo -e "Predeploy actions \n\n\n"
pwd
ls -a
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


#---------------------------temp comment--------------------------------------
##get to classes directory to define the list of tests to be executed
#cd force-app/main/default/classes/tests

#add all the files in the folder into array
#mapfile -t classes_files_array < <( ls )

#define which of the files are tests
#COUNT=0
#ARRAY_LEN=${#classes_files_array[@]}
#LIST_OF_FILES_TO_TEST=""
#LOOP_LEN=$( expr $ARRAY_LEN - 1)


#while [ $COUNT -le $LOOP_LEN ]
#do
#    if [[ ${classes_files_array[$COUNT]} == *"Test.cls"* ]];
#    then

#        if [[ ${classes_files_array[$COUNT]} == *"cls-meta.xml"* ]];
#        then
#            LIST_OF_XML_FILES=$LIST_OF_XML_FILES{classes_files_array[$COUNT]}","
#        else
#            LEN_OF_FILE_NAME=${#classes_files_array[$COUNT]}
#            NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_FILE_NAME - 4 )
#            FILE_NAME_TRUNC=$((echo ${classes_files_array[$COUNT]}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )
#            LIST_OF_FILES_TO_TEST=$LIST_OF_FILES_TO_TEST$FILE_NAME_TRUNC","
#        fi

#    fi 
#    COUNT=$(( $COUNT +1))
#done


#LEN_OF_LIST_OF_FILES_TO_TEST=${#LIST_OF_FILES_TO_TEST}

#NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_LIST_OF_FILES_TO_TEST - 1 )

#LIST_OF_FILES_TO_TEST_TRUNC=$((echo ${LIST_OF_FILES_TO_TEST}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

#echo -e "\n\n\nList of files to test\n\n\n"
#echo $LIST_OF_FILES_TO_TEST_TRUNC
#---------------------------temp comment--------------------------------------

#get back to the root directory
cd /home/circleci/project
git checkout $SOURCE_BRANCH_NAME


echo -e "\n\n\nOutput list of files to be deployed logic execution"



echo "Test deploy to Salesforce env without saving \n\n\n"
#sfdx force:source:deploy -p ${FILES_TO_DEPLOY} -c -l RunSpecifiedTests -r ${LIST_OF_FILES_TO_TEST_TRUNC} -u ${SALESFORCE_TARGET_ORG_ALIAS} --loglevel WARN




#test. delete
FILES_TO_DEPLOY="force-app/main/default"
#test. delete
if [[ $FILES_TO_DEPLOY == *"force-app/main/default"* ]];
then
    STRING_NESTED_FILES_1=""

    #get into force-app/main/default
    cd force-app/main/default
    #get list of folders nested in force-app/main/default
    mapfile -t forceapp_files_array < <( ls )
    LOOP_ROOT_DIR="/home/circleci/project/force-app/main/default"

    COUNT=0
    ARRAY_LEN=${#forceapp_files_array[@]}
    LIST_OF_FILES_TO_TEST=""
    LOOP_LEN=$( expr $ARRAY_LEN - 1)

    # start of the loop to check each folder in force-app/main/default
    while [ $COUNT -le $LOOP_LEN ]
    do
        cd ${forceapp_files_array[$COUNT]}
        ls -a
        mapfile -t current_folder_files_array < <( ls -a )


#nesting level 01----------------------------------------------------------------
        COUNT_02=2
        ARRAY_LEN_02=${#current_folder_files_array[@]}
        LIST_OF_FILES_TO_TEST_02=""
        LOOP_LEN_02=$( expr $ARRAY_LEN_02 - 1)

        while [ $COUNT_02 -le $LOOP_LEN_02 ]
        do
            if [[ -f ${current_folder_files_array[$COUNT_02]} ]];
            then
                STRING_NESTED_FILES_1=$STRING_NESTED_FILES_1${forceapp_files_array[$COUNT]}"/"${current_folder_files_array[$COUNT_02]}","
            else

#nesting level 02--------------------------------------------------------------------
                cd ${current_folder_files_array[$COUNT_02]}
                ls -a
                mapfile -t current_folder_files_array_02 < <( ls -a )

                COUNT_03=2
                ARRAY_LEN_03=${#current_folder_files_array_02[@]}
                LIST_OF_FILES_TO_TEST_03=""
                LOOP_LEN_03=$( expr $ARRAY_LEN_03 - 1)

                while [ $COUNT_03 -le $LOOP_LEN_03 ]
                do
                    if [[ -f ${current_folder_files_array_02[$COUNT_03]} ]];
                    then
                        STRING_NESTED_FILES_2=$STRING_NESTED_FILES_2${forceapp_files_array[$COUNT]}" --> "${current_folder_files_array[$COUNT_02]}"/"${current_folder_files_array_02[$COUNT_03]}","
                    else
#nesting level 03---------------------------------------------------------------------------------------------------------------------------------------
                        cd ${current_folder_files_array_02[$COUNT_03]}
                        ls -a
                        mapfile -t current_folder_files_array_03 < <( ls -a )

                        COUNT_04=2
                        ARRAY_LEN_04=${#current_folder_files_array_03[@]}
                        LIST_OF_FILES_TO_TEST_04=""
                        LOOP_LEN_04=$( expr $ARRAY_LEN_04 - 1)

                        while [ $COUNT_04 -le $LOOP_LEN_04 ]
                        do
                            if [[ -f ${current_folder_files_array_03[$COUNT_04]} ]];
                            then
                                STRING_NESTED_FILES_3=$STRING_NESTED_FILES_3${forceapp_files_array[$COUNT]}" --> "${current_folder_files_array[$COUNT_02]}" --> "${current_folder_files_array_02[$COUNT_03]}"/"${current_folder_files_array_03[$COUNT_04]}","
                            else
#nesting level 04---------------------------------------------------------------------------------------------------------------------------------------
                                cd ${current_folder_files_array_03[$COUNT_04]}
                                ls -a
                                mapfile -t current_folder_files_array_04 < <( ls -a )

                                COUNT_05=2
                                ARRAY_LEN_05=${#current_folder_files_array_04[@]}
                                LIST_OF_FILES_TO_TEST_05=""
                                LOOP_LEN_05=$( expr $ARRAY_LEN_05 - 1)

                                while [ $COUNT_05 -le $LOOP_LEN_05 ]
                                do
                                    if [[ -f ${current_folder_files_array_04[$COUNT_05]} ]];
                                    then
                                        STRING_NESTED_FILES_4=$STRING_NESTED_FILES_4${forceapp_files_array[$COUNT]}" --> "${current_folder_files_array[$COUNT_02]}" --> "${current_folder_files_array_02[$COUNT_03]}" --> "${current_folder_files_array_03[$COUNT_04]}"/"${current_folder_files_array_04[$COUNT_05]}","
                                    else
#nesting level 05---------------------------------------------------------------------------------------------------------------------------------------
                                        cd ${current_folder_files_array_04[$COUNT_05]}
                                        ls -a
                                        mapfile -t current_folder_files_array_05 < <( ls -a )

                                        COUNT_06=2
                                        ARRAY_LEN_06=${#current_folder_files_array_05[@]}
                                        LIST_OF_FILES_TO_TEST_06=""
                                        LOOP_LEN_06=$( expr $ARRAY_LEN_06 - 1)

                                        while [ $COUNT_06 -le $LOOP_LEN_06 ]
                                        do
                                            if [[ -f ${current_folder_files_array_05[$COUNT_06]} ]];
                                            then
                                                STRING_NESTED_FILES_5=$STRING_NESTED_FILES_4${forceapp_files_array[$COUNT]}" --> "${current_folder_files_array[$COUNT_02]}" --> "${current_folder_files_array_02[$COUNT_03]}" --> "${current_folder_files_array_03[$COUNT_04]}" --> "${current_folder_files_array_04[$COUNT_05]}"/"${current_folder_files_array_05[$COUNT_06]}","
                                            fi
                                            COUNT_06=$(( $COUNT_06 +1))
                                        done
                                        cd ..
#nesting level 05---------------------------------------------------------------------------------------------------------------------------------------
                                    fi
                                    COUNT_05=$(( $COUNT_05 +1))
                                done
                                cd ..
#nesting level 04---------------------------------------------------------------------------------------------------------------------------------------
                            fi
                            COUNT_04=$(( $COUNT_04 +1))
                        done
                        cd ..
#nesting level 03----------------------------------------------------------------------------------------------------------------------------------------
                    fi
                    COUNT_03=$(( $COUNT_03 +1))
                done
                cd ..
#nesting level 02--------------------------------------------------------------------
            fi 
            COUNT_02=$(( $COUNT_02 +1))
        done

        cd $LOOP_ROOT_DIR
        COUNT=$(( $COUNT +1))
    done
#-------------------TRUE logic start------------------------------------
else
    echo "FALSE"
fi




#NESTED 1-----------------------------------------------------------------------------------------------------------------------------------
STRING_NESTED_FILES_1_LEN=${#STRING_NESTED_FILES_1}

if [[ $STRING_NESTED_FILES_1_LEN > 0 ]];
then
    STRING_NESTED_FILES_1_EMPTY=0
    LEN_OF_STRING_NESTED_FILES_1=${#STRING_NESTED_FILES_1}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_1 - 1 )
    STRING_NESTED_FILES_1_TRUNC=$((echo ${STRING_NESTED_FILES_1}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    IFS=',' read -r -a string_nested_files_1_trunc_array <<< "$STRING_NESTED_FILES_1_TRUNC"

    COUNT_NEST_1=0
    ARRAY_LEN_NEST_1=${#string_nested_files_1_trunc_array[@]}
    LIST_OF_FILES_TO_TEST_NEST_1=""
    LOOP_LEN_NEST_1=$( expr $ARRAY_LEN_NEST_1 - 1)
    COLLECT_XML_FILES=""


    while [ $COUNT_NEST_1 -le $LOOP_LEN_NEST_1 ]
    do
        if [[ ${string_nested_files_1_trunc_array[$COUNT_NEST_1]} == *".xml"* ]];
        then
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_1_trunc_array[$COUNT_NEST_1]}","
        fi
        COUNT_NEST_1=$(( $COUNT_NEST_1 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_1_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

else
    STRING_NESTED_FILES_1_EMPTY=1
fi  
#NESTED 1-----------------------------------------------------------------------------------------------------------------------------------

STRING_NESTED_FILES_2_LEN=${#STRING_NESTED_FILES_2}

if [[ $STRING_NESTED_FILES_2_LEN > 0 ]];
then
    STRING_NESTED_FILES_2_EMPTY=0

    LEN_OF_STRING_NESTED_FILES_2=${#STRING_NESTED_FILES_2}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_2 - 1 )
    STRING_NESTED_FILES_2_TRUNC=$((echo ${STRING_NESTED_FILES_2}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    IFS=',' read -r -a string_nested_files_2_trunc_array <<< "$STRING_NESTED_FILES_2_TRUNC"

    COUNT_NEST_2=0
    ARRAY_LEN_NEST_2=${#string_nested_files_2_trunc_array[@]}
    echo $ARRAY_LEN_NEST_2
    LIST_OF_FILES_TO_TEST_NEST_2=""
    LOOP_LEN_NEST_2=$( expr $ARRAY_LEN_NEST_2 - 1)
    COLLECT_XML_FILES=""

    while [ $COUNT_NEST_2 -le $LOOP_LEN_NEST_2 ]
    do
        if [[ ${string_nested_files_2_trunc_array[$COUNT_NEST_2]} == *".xml"* ]];
        then
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_2_trunc_array[$COUNT_NEST_2]}","
        else
            echo ${string_nested_files_2_trunc_array[$COUNT_NEST_2]}
        fi
        COUNT_NEST_2=$(( $COUNT_NEST_2 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_2_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

else
    STRING_NESTED_FILES_2_EMPTY=1
fi  





STRING_NESTED_FILES_3_LEN=${#STRING_NESTED_FILES_3}

if [[ $STRING_NESTED_FILES_3_LEN > 0 ]];
then
    STRING_NESTED_FILES_3_EMPTY=0

    LEN_OF_STRING_NESTED_FILES_3=${#STRING_NESTED_FILES_3}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_3 - 1 )
    STRING_NESTED_FILES_3_TRUNC=$((echo ${STRING_NESTED_FILES_3}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    IFS=',' read -r -a string_nested_files_3_trunc_array <<< "$STRING_NESTED_FILES_3_TRUNC"

    COUNT_NEST_3=0
    ARRAY_LEN_NEST_3=${#string_nested_files_3_trunc_array[@]}
    LIST_OF_FILES_TO_TEST_NEST_3=""
    LOOP_LEN_NEST_3=$( expr $ARRAY_LEN_NEST_3 - 1)
    COLLECT_XML_FILES=""

    while [ $COUNT_NEST_3 -le $LOOP_LEN_NEST_3 ]
    do
        if [[ ${string_nested_files_3_trunc_array[$COUNT_NEST_3]} == *".xml"* ]];
        then
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_3_trunc_array[$COUNT_NEST_3]}","
        else
            echo ${string_nested_files_3_trunc_array[$COUNT_NEST_3]}
        fi
        COUNT_NEST_3=$(( $COUNT_NEST_3 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_3_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

else
    STRING_NESTED_FILES_3_EMPTY=1
fi







STRING_NESTED_FILES_4_LEN=${#STRING_NESTED_FILES_4}

if [[ $STRING_NESTED_FILES_4_LEN > 0 ]];
then
    STRING_NESTED_FILES_4_EMPTY=1

    LEN_OF_STRING_NESTED_FILES_4=${#STRING_NESTED_FILES_4}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_4 - 1 )
    STRING_NESTED_FILES_4_TRUNC=$((echo ${STRING_NESTED_FILES_4}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    IFS=',' read -r -a string_nested_files_4_trunc_array <<< "$STRING_NESTED_FILES_4_TRUNC"

    COUNT_NEST_4=0
    ARRAY_LEN_NEST_4=${#string_nested_files_4_trunc_array[@]}
    LIST_OF_FILES_TO_TEST_NEST_4=""
    LOOP_LEN_NEST_4=$( expr $ARRAY_LEN_NEST_4 - 1)
    COLLECT_XML_FILES=""


    while [ $COUNT_NEST_4 -le $LOOP_LEN_NEST_4 ]
    do
        if [[ ${string_nested_files_4_trunc_array[$COUNT_NEST_4]} == *".xml"* ]];
        then
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_4_trunc_array[$COUNT_NEST_4]}","
        else
            echo ${string_nested_files_4_trunc_array[$COUNT_NEST_4]}
        fi
        COUNT_NEST_4=$(( $COUNT_NEST_4 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_4_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

else
    STRING_NESTED_FILES_4_EMPTY=1
fi









STRING_NESTED_FILES_5_LEN=${#STRING_NESTED_FILES_5}


if [[ $STRING_NESTED_FILES_5_LEN > 0 ]];
then
    STRING_NESTED_FILES_5_EMPTY=0

    LEN_OF_STRING_NESTED_FILES_5=${#STRING_NESTED_FILES_5}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_5 - 1 )
    STRING_NESTED_FILES_5_TRUNC=$((echo ${STRING_NESTED_FILES_5}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    IFS=',' read -r -a string_nested_files_5_trunc_array <<< "$STRING_NESTED_FILES_5_TRUNC"

    COUNT_NEST_5=0
    ARRAY_LEN_NEST_5=${#string_nested_files_5_trunc_array[@]}
    echo $ARRAY_LEN_NEST_5
    LIST_OF_FILES_TO_TEST_NEST_5=""
    LOOP_LEN_NEST_5=$( expr $ARRAY_LEN_NEST_5 - 1)
    COLLECT_XML_FILES=""

    while [ $COUNT_NEST_5 -le $LOOP_LEN_NEST_5 ]
    do
        if [[ ${string_nested_files_5_trunc_array[$COUNT_NEST_5]} == *".xml"* ]];
        then
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_5_trunc_array[$COUNT_NEST_5]}","
        else
            echo ${string_nested_files_5_trunc_array[$COUNT_NEST_5]}
        fi
        COUNT_NEST_5=$(( $COUNT_NEST_5 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_5_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

else
    STRING_NESTED_FILES_5_EMPTY=1
fi



echo "***********************************************************************************************"
echo "***********************************************************************************************"
echo "***********************************************************************************************"
echo "---------------------------  === LIST OF FILES ===  -------------------------------------------"
echo "---------------------------  === START OF THE LIST ===  ---------------------------------------"
echo "                                                                                              |"
echo "                                                                                              |"
echo "                                                                                              |"
echo -e "                                                                                              |\n\n\n"

if [[ $STRING_NESTED_FILES_1_EMPTY == 0 ]];
then
    IFS=',' read -r -a display_array_01 <<< "$STRING_NESTED_FILES_1_TRUNC"

    COUNT_01=0
    ARRAY_LEN_01=${#display_array_01[@]}
    LOOP_LEN_01=$( expr $ARRAY_LEN_01 - 1)

    while [ $COUNT_01 -le $LOOP_LEN_01 ]
    do
        folder=$(echo ${display_array_01[$COUNT_01]} | cut -d\/ -f1)
        file=$(echo ${display_array_01[$COUNT_01]} | cut -d\/ -f2)
        echo -e "$folder: $file"
        COUNT_01=$(( $COUNT_01 + 1 ))
    done

fi




if [[ $STRING_NESTED_FILES_2_EMPTY == 0 ]];
then
    IFS=',' read -r -a display_array_02 <<< "$STRING_NESTED_FILES_2_TRUNC"
    echo -e "\n|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n"
    COUNT_02=0
    ARRAY_LEN_02=${#display_array_02[@]}
    LOOP_LEN_02=$( expr $ARRAY_LEN_02 - 1)

    while [ $COUNT_02 -le $LOOP_LEN_02 ]
    do
        folder=$(echo ${display_array_02[$COUNT_02]} | cut -d\/ -f1)
        file=$(echo ${display_array_02[$COUNT_02]} | cut -d\/ -f2)
        echo -e "$folder: $file"
        COUNT_02=$(( $COUNT_02 + 1 ))
    done

fi




if [[ $STRING_NESTED_FILES_3_EMPTY == 0 ]];
then
    IFS=',' read -r -a display_array_03 <<< "$STRING_NESTED_FILES_3_TRUNC"
    echo -e "\n|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n"
    COUNT_03=0
    ARRAY_LEN_03=${#display_array_03[@]}
    LOOP_LEN_03=$( expr $ARRAY_LEN_03 - 1)

    while [ $COUNT_03 -le $LOOP_LEN_03 ]
    do
        folder=$(echo ${display_array_03[$COUNT_03]} | cut -d\/ -f1)
        file=$(echo ${display_array_03[$COUNT_03]} | cut -d\/ -f2)
        echo -e "$folder: $file"
        COUNT_03=$(( $COUNT_03 + 1 ))
    done

fi




if [[ $STRING_NESTED_FILES_4_EMPTY == 0 ]];
then
    IFS=',' read -r -a display_array_04 <<< "$STRING_NESTED_FILES_4_TRUNC"
    echo -e "\n|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n"
    COUNT_04=0
    ARRAY_LEN_04=${#display_array_04[@]}
    LOOP_LEN_04=$( expr $ARRAY_LEN_04 - 1)

    while [ $COUNT_04 -le $LOOP_LEN_04 ]
    do
        folder=$(echo ${display_array_04[$COUNT_04]} | cut -d\/ -f1)
        file=$(echo ${display_array_04[$COUNT_04]} | cut -d\/ -f2)
        echo -e "$folder: $file"
        COUNT_04=$(( $COUNT_04 + 1 ))
    done

fi




if [[ $STRING_NESTED_FILES_5_EMPTY == 0 ]];
then
    IFS=',' read -r -a display_array_05 <<< "$STRING_NESTED_FILES_5_TRUNC"
    echo -e "\n|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n"
    COUNT_05=0
    ARRAY_LEN_05=${#display_array_05[@]}
    LOOP_LEN_05=$( expr $ARRAY_LEN_05 - 1)

    while [ $COUNT_05 -le $LOOP_LEN_05 ]
    do
        folder=$(echo ${display_array_05[$COUNT_05]} | cut -d\/ -f1)
        file=$(echo ${display_array_05[$COUNT_05]} | cut -d\/ -f2)
        echo -e "$folder: $file"
        COUNT_05=$(( $COUNT_05 + 1 ))
    done

fi




echo -e "\n\n\n                                                                                              |"
echo "                                                                                              |"
echo "                                                                                              |"
echo "                                                                                              |"
echo "---------------------------  === END OF THE LIST ===  -----------------------------------------"
echo "***********************************************************************************************"
echo "***********************************************************************************************"
echo "***********************************************************************************************"

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@"