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
                                echo -e "\nxxxx"
                                echo "NEST 3"
                                echo "FILE IS"
                                echo ${current_folder_files_array_03[$COUNT_04]}
                                echo "THIS IS FILE"
                                echo -e "xxxx\n"
                                STRING_NESTED_FILES_3=$STRING_NESTED_FILES_3${forceapp_files_array[$COUNT]}" -->"${current_folder_files_array[$COUNT_02]}"-->"${current_folder_files_array_02[$COUNT_03]}"/"${current_folder_files_array_03[$COUNT_04]}","
                            else
                                echo -e "\nxxxx"
                                echo "NEST 3"
                                echo "FILE IS"
                                echo ${current_folder_files_array_03[$COUNT_04]}
                                echo "THIS IS DIRECTORY"
                                echo -e "xxxx\n"
#nesting level 04---------------------------------------------------------------------------------------------------------------------------------------
                                echo "get inside of the ___ "${current_folder_files_array_03[$COUNT_04]}" ___ directory"
                                cd ${current_folder_files_array_03[$COUNT_04]}
                                echo "inside or the dir is the following"
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
                                        echo -e "\nxxxx"
                                        echo "NEST 3"
                                        echo "FILE IS"
                                        echo ${current_folder_files_array_04[$COUNT_05]}
                                        echo "THIS IS FILE"
                                        echo -e "xxxx\n"
                                        STRING_NESTED_FILES_4=$STRING_NESTED_FILES_4${forceapp_files_array[$COUNT]}" -->"${current_folder_files_array[$COUNT_02]}"-->"${current_folder_files_array_02[$COUNT_03]}"-->"${current_folder_files_array_03[$COUNT_04]}"-->""/"${current_folder_files_array_04[$COUNT_05]}","
                                    else
                                        echo -e "\nxxxx"
                                        echo "NEST 3"
                                        echo "FILE IS"
                                        echo ${current_folder_files_array_04[$COUNT_05]}
                                        echo "THIS IS DIRECTORY"
                                        echo -e "xxxx\n"
#nesting level 05---------------------------------------------------------------------------------------------------------------------------------------
                                        echo "get inside of the ___ "${current_folder_files_array_04[$COUNT_05]}" ___ directory"
                                        cd ${current_folder_files_array_04[$COUNT_05]}
                                        echo "inside or the dir is the following"
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
                                                echo -e "\nxxxx"
                                                echo "NEST 3"
                                                echo "FILE IS"
                                                echo ${current_folder_files_array_05[$COUNT_06]}
                                                echo "THIS IS FILE"
                                                echo -e "xxxx\n"
                                                STRING_NESTED_FILES_5=$STRING_NESTED_FILES_4${forceapp_files_array[$COUNT]}" -->"${current_folder_files_array[$COUNT_02]}"-->"${current_folder_files_array_02[$COUNT_03]}"-->"${current_folder_files_array_03[$COUNT_04]}"-->"${current_folder_files_array_04[$COUNT_05]}"/"${current_folder_files_array_05[$COUNT_06]}","
                                            else
                                                echo -e "\nxxxx"
                                                echo "NEST 3"
                                                echo "FILE IS"
                                                echo ${current_folder_files_array_05[$COUNT_06]}
                                                echo "THIS IS DIRECTORY"
                                                echo -e "xxxx\n"
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

STRING_NESTED_FILES_1_LEN=${#STRING_NESTED_FILES_1}

if [[ $STRING_NESTED_FILES_1_LEN > 0 ]];
then
    echo "STRING_NESTED_FILES_1 is NOT empty"
    STRING_NESTED_FILES_1_EMPTY=0
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
else
    echo "STRING_NESTED_FILES_1 is empty"
    STRING_NESTED_FILES_1_EMPTY=1
fi  
#NESTED 1-----------------------------------------------------------------------------------------------------------------------------------
echo -e "NESTED 1-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"


echo -e "\n\n\nNESTED 2-----------------------------------------------------------------------------------------------------------------------------------"
echo "STRING_NESTED_FILES_2"
echo $STRING_NESTED_FILES_2

STRING_NESTED_FILES_2_LEN=${#STRING_NESTED_FILES_2}

if [[ $STRING_NESTED_FILES_2_LEN > 0 ]];
then
    echo "STRING_NESTED_FILES_2 is NOT empty"
    STRING_NESTED_FILES_2_EMPTY=0

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
else
    echo "STRING_NESTED_FILES_2 is empty"
    STRING_NESTED_FILES_2_EMPTY=1
fi  
echo -e "NESTED 2-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"




echo -e "\n\n\nNESTED 3-----------------------------------------------------------------------------------------------------------------------------------"
echo "STRING_NESTED_FILES_3"
echo $STRING_NESTED_FILES_3

STRING_NESTED_FILES_3_LEN=${#STRING_NESTED_FILES_3}

if [[ $STRING_NESTED_FILES_3_LEN > 0 ]];
then
    echo "STRING_NESTED_FILES_3 is NOT empty"
    STRING_NESTED_FILES_3_EMPTY=0

    LEN_OF_STRING_NESTED_FILES_3=${#STRING_NESTED_FILES_3}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_3 - 1 )
    STRING_NESTED_FILES_3_TRUNC=$((echo ${STRING_NESTED_FILES_3}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    echo -e "\n\n\nSTRING_NESTED_FILES_3_TRUNC\n\n\n"
    echo $STRING_NESTED_FILES_3_TRUNC


    IFS=',' read -r -a string_nested_files_3_trunc_array <<< "$STRING_NESTED_FILES_3_TRUNC"


    COUNT_NEST_3=0
    ARRAY_LEN_NEST_3=${#string_nested_files_3_trunc_array[@]}
    echo $ARRAY_LEN_NEST_3
    LIST_OF_FILES_TO_TEST_NEST_3=""
    LOOP_LEN_NEST_3=$( expr $ARRAY_LEN_NEST_3 - 1)
    COLLECT_XML_FILES=""


    while [ $COUNT_NEST_3 -le $LOOP_LEN_NEST_3 ]
    do
        if [[ ${string_nested_files_3_trunc_array[$COUNT_NEST_3]} == *".xml"* ]];
        then
            echo "TRUE"
            echo ${string_nested_files_3_trunc_array[$COUNT_NEST_3]}
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_3_trunc_array[$COUNT_NEST_3]}","
        else
            echo "FALSE"
            echo ${string_nested_files_3_trunc_array[$COUNT_NEST_3]}
        fi
        COUNT_NEST_3=$(( $COUNT_NEST_3 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_3_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    echo -e "\n\n\nFINAL ___ STRING_NESTED_FILES_3_TRUNC-------\n\n\n"
    echo $STRING_NESTED_FILES_3_TRUNC
else
    echo "STRING_NESTED_FILES_3 is empty"
    STRING_NESTED_FILES_3_EMPTY=1
fi


echo -e "NESTED 3-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"




echo -e "\n\n\nNESTED 4-----------------------------------------------------------------------------------------------------------------------------------"
echo "STRING_NESTED_FILES_4"
echo $STRING_NESTED_FILES_4

STRING_NESTED_FILES_4_LEN=${#STRING_NESTED_FILES_4}

if [[ $STRING_NESTED_FILES_4_LEN > 0 ]];
then
    echo "STRING_NESTED_FILES_4 is NOT empty"
    STRING_NESTED_FILES_4_EMPTY=1

    LEN_OF_STRING_NESTED_FILES_4=${#STRING_NESTED_FILES_4}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_4 - 1 )
    STRING_NESTED_FILES_4_TRUNC=$((echo ${STRING_NESTED_FILES_4}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    echo -e "\n\n\nSTRING_NESTED_FILES_4_TRUNC\n\n\n"
    echo $STRING_NESTED_FILES_4_TRUNC


    IFS=',' read -r -a string_nested_files_4_trunc_array <<< "$STRING_NESTED_FILES_4_TRUNC"


    COUNT_NEST_4=0
    ARRAY_LEN_NEST_4=${#string_nested_files_4_trunc_array[@]}
    echo $ARRAY_LEN_NEST_4
    LIST_OF_FILES_TO_TEST_NEST_4=""
    LOOP_LEN_NEST_4=$( expr $ARRAY_LEN_NEST_4 - 1)
    COLLECT_XML_FILES=""


    while [ $COUNT_NEST_4 -le $LOOP_LEN_NEST_4 ]
    do
        if [[ ${string_nested_files_4_trunc_array[$COUNT_NEST_4]} == *".xml"* ]];
        then
            echo "TRUE"
            echo ${string_nested_files_4_trunc_array[$COUNT_NEST_4]}
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_4_trunc_array[$COUNT_NEST_4]}","
        else
            echo "FALSE"
            echo ${string_nested_files_4_trunc_array[$COUNT_NEST_4]}
        fi
        COUNT_NEST_4=$(( $COUNT_NEST_4 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_4_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    echo -e "\n\n\nFINAL ___ STRING_NESTED_FILES_4_TRUNC-------\n\n\n"
    echo $STRING_NESTED_FILES_4_TRUNC
else
    echo "STRING_NESTED_FILES_4 is empty"
    STRING_NESTED_FILES_4_EMPTY=1
fi




echo -e "NESTED 4-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"




echo -e "\n\n\nNESTED 5-----------------------------------------------------------------------------------------------------------------------------------"
echo "STRING_NESTED_FILES_5"
echo $STRING_NESTED_FILES_5

STRING_NESTED_FILES_5_LEN=${#STRING_NESTED_FILES_5}


if [[ $STRING_NESTED_FILES_5_LEN > 0 ]];
then
    echo "STRING_NESTED_FILES_5 is NOT empty"
    STRING_NESTED_FILES_5_EMPTY=0



    LEN_OF_STRING_NESTED_FILES_5=${#STRING_NESTED_FILES_5}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_STRING_NESTED_FILES_5 - 1 )
    STRING_NESTED_FILES_5_TRUNC=$((echo ${STRING_NESTED_FILES_5}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    echo -e "\n\n\nSTRING_NESTED_FILES_5_TRUNC\n\n\n"
    echo $STRING_NESTED_FILES_5_TRUNC


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
            echo "TRUE"
            echo ${string_nested_files_5_trunc_array[$COUNT_NEST_5]}
            COLLECT_XML_FILES=$COLLECT_XML_FILES${string_nested_files_5_trunc_array[$COUNT_NEST_5]}","
        else
            echo "FALSE"
            echo ${string_nested_files_5_trunc_array[$COUNT_NEST_5]}
        fi
        COUNT_NEST_5=$(( $COUNT_NEST_5 +1))
    done

    LEN_OF_COLLECT_XML_FILES=${#COLLECT_XML_FILES}
    NUMBER_OF_SYMBOLS_TO_TRUNCATE=$( expr $LEN_OF_COLLECT_XML_FILES - 1 )
    STRING_NESTED_FILES_5_TRUNC=$((echo ${COLLECT_XML_FILES}) | cut -c 1-$NUMBER_OF_SYMBOLS_TO_TRUNCATE )

    echo -e "\n\n\nFINAL ___ STRING_NESTED_FILES_5_TRUNC-------\n\n\n"
    echo $STRING_NESTED_FILES_5_TRUNC
    echo -e "NESTED 5-----------------------------------------------------------------------------------------------------------------------------------\n\n\n"
else
    echo "STRING_NESTED_FILES_5 is empty"
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
echo "                                                                                              |"

if [[ $STRING_NESTED_FILES_1_EMPTY == 0 ]];
then
    echo $STRING_NESTED_FILES_1_TRUNC
    IFS=',' read -r -a display_array_01 <<< "$STRING_NESTED_FILES_1_TRUNC"

    COUNT_01=0
    ARRAY_LEN_01=${#display_array_01[@]}
    LOOP_LEN_01=$( expr $ARRAY_LEN_01 - 1)

    while [ $COUNT_01 -le $LOOP_LEN_01 ]
    do
        echo "LOOP STEP ___"$COUNT_01"__"
        echo ${display_array_01[@]}
        COUNT_01=$(( $COUNT_01 + 1 ))
    done

fi




echo "                                                                                              |"
echo "                                                                                              |"
echo "                                                                                              |"
echo "                                                                                              |"
echo "---------------------------  === END OF THE LIST ===  -----------------------------------------"
echo "***********************************************************************************************"
echo "***********************************************************************************************"
echo "***********************************************************************************************"

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@"