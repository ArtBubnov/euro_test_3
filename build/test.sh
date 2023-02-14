echo "@@@@@@@@@@@@@@@@@@@@@@@@@@"
#test. delete
FILES_TO_DEPLOY="force-app/main/default"
#test. delete
echo "loop start"
if [[ $FILES_TO_DEPLOY == *"force-app/main/default"* ]];
then
#-------------------TRUE logic start------------------------------------
    echo "TRUE"
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
        echo -e "\n\n\nLOOP STEP START"
        echo -e "\nName of the folder"
        echo ${forceapp_files_array[$COUNT]}
        echo -e "\nWhat is in the foleder\n"
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
                echo -e "\n***"
                echo "FILE IS"
                echo ${current_folder_files_array[$COUNT_02]}
                echo "THIS IS FILE"
                echo -e "***\n"
                STRING_NESTED_FILES_1=$STRING_NESTED_FILES_1${forceapp_files_array[$COUNT]}"/"${current_folder_files_array[$COUNT_02]}","
            else
                echo -e "\n***"
                echo "FILE IS"
                echo ${current_folder_files_array[$COUNT_02]}
                echo "THIS IS DIRECTORY"
                echo -e "\n"

#nesting level 02--------------------------------------------------------------------
                echo "get inside of the ___ "${current_folder_files_array[$COUNT_02]}" ___ directory"
                cd ${current_folder_files_array[$COUNT_02]}
                echo "inside or the dir is the following"
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
                        echo -e "\n!!!!"
                        echo "NEST 2"
                        echo "FILE IS"
                        echo ${current_folder_files_array_02[$COUNT_03]}
                        echo "THIS IS FILE"
                        echo -e "!!!\n"
                        STRING_NESTED_FILES_2=$STRING_NESTED_FILES_2${forceapp_files_array[$COUNT]}"-->"${current_folder_files_array[$COUNT_02]}"/"${current_folder_files_array_02[$COUNT_03]}","
                    else
                        echo -e "\n!!!"
                        echo "NEST 2"
                        echo "FILE IS"
                        echo ${current_folder_files_array_02[$COUNT_03]}
                        echo "THIS IS DIRECTORY"
                        echo -e "!!!\n"
#nesting level 03---------------------------------------------------------------------------------------------------------------------------------------
                        echo "get inside of the ___ "${current_folder_files_array_02[$COUNT_03]}" ___ directory"
                        cd ${current_folder_files_array_02[$COUNT_03]}
                        echo "inside or the dir is the following"
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
                                echo -e "\n!!!!"
                                echo "NEST 2"
                                echo "FILE IS"
                                echo ${current_folder_files_array_03[$COUNT_04]}
                                echo "THIS IS FILE"
                                echo -e "!!!\n"
                                STRING_NESTED_FILES_3=$STRING_NESTED_FILES_2${forceapp_files_array[$COUNT]}" -->"${current_folder_files_array[$COUNT_02]}"-->"${current_folder_files_array_02[$COUNT_03]}"/"${current_folder_files_array_03[$COUNT_04]}","
                            else
                                echo -e "\n!!!"
                                echo "NEST 2"
                                echo "FILE IS"
                                echo ${current_folder_files_array_03[$COUNT_04]}
                                echo "THIS IS DIRECTORY"
                                echo -e "!!!\n"

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
        echo -e "\nLOOP STEP END\n\n\n"
        COUNT=$(( $COUNT +1))
    done
#-------------------TRUE logic start------------------------------------
else
    echo "FALSE"
fi






































#NESTED 1-----------------------------------------------------------------------------------------------------------------------------------
echo -e "\n\n\nNESTED 1-----------------------------------------------------------------------------------------------------------------------------------"
echo "STRING_NESTED_FILES_1"
echo $STRING_NESTED_FILES_1
LEN_OF_STRING_NESTED_FILES_1=${#STRING_NESTED_FILES_1}
NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_1 - 1 )
STRING_NESTED_FILES_1_TRUNC=$((echo ${STRING_NESTED_FILES_1}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

echo -e "\n\n\nSTRING_NESTED_FILES_1_TRUNC\n\n\n"
echo $STRING_NESTED_FILES_1_TRUNC


IFS=',' read -r -a string_nested_files_1_trunc_array <<< "$STRING_NESTED_FILES_1_TRUNC"


COUNT_NEST_1=0
ARRAY_LEN_NEST_1=${#string_nested_files_1_trunc_array[@]}
echo $ARRAY_LEN_NEST_1
LIST_OF_FILES_TO_TEST_NEST_1=""
LOOP_LEN_NEST_1=$( expr $ARRAY_LEN_NEST_1 - 1)
COLLECT_XML_FILES=""


while [ $COUNT_NEST_1 -le $LOOP_LEN_NEST_1 ]
do
    if [[ ${string_nested_files_1_trunc_array[$COUNT_NEST_1]} == *".xml"* ]];
    then
        echo "TRUE"
        echo ${string_nested_files_1_trunc_array[$COUNT_NEST_1]}
        COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_1_trunc_array[$COUNT_NEST_1]}","
    else
        echo "FALSE"
        echo ${string_nested_files_1_trunc_array[$COUNT_NEST_1]}
    fi
    COUNT_NEST_1=$(( $COUNT_NEST_1 +1))
done

LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
STRING_NESTED_FILES_1_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

echo -e "\n\n\nFINAL ___ STRING_NESTED_FILES_1_TRUNC-------\n\n\n"
echo $STRING_NESTED_FILES_1_TRUNC
#NESTED 1-----------------------------------------------------------------------------------------------------------------------------------
echo -e "NESTED 1-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"


echo -e "\n\n\nNESTED 2-----------------------------------------------------------------------------------------------------------------------------------"
echo "STRING_NESTED_FILES_2"
echo $STRING_NESTED_FILES_2
LEN_OF_STRING_NESTED_FILES_2=${#STRING_NESTED_FILES_2}
NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_2 - 1 )
STRING_NESTED_FILES_2_TRUNC=$((echo ${STRING_NESTED_FILES_2}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

echo -e "\n\n\nSTRING_NESTED_FILES_2_TRUNC\n\n\n"
echo $STRING_NESTED_FILES_2_TRUNC


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
        echo "TRUE"
        echo ${string_nested_files_2_trunc_array[$COUNT_NEST_2]}
        COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_2_trunc_array[$COUNT_NEST_2]}","
    else
        echo "FALSE"
        echo ${string_nested_files_2_trunc_array[$COUNT_NEST_2]}
    fi
    COUNT_NEST_2=$(( $COUNT_NEST_2 +1))
done

LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
STRING_NESTED_FILES_2_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

echo -e "\n\n\nFINAL ___ STRING_NESTED_FILES_2_TRUNC-------\n\n\n"
echo $STRING_NESTED_FILES_2_TRUNC
echo -e "NESTED 2-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"

echo -e "\n\n\nNESTED 3-----------------------------------------------------------------------------------------------------------------------------------"
echo $STRING_NESTED_FILES_3
echo -e "NESTED 3-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"




echo "@@@@@@@@@@@@@@@@@@@@@@@@@@"