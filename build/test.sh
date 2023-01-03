echo -e "test\n\n\n"
CIRCLE_TOKEN=7a87730dbe7ce5fdc8b4c5129bf095ad2d6d954a

echo "*******************"
echo $CIRCLE_BUILD_NUM
echo "*******************"


TEST=curl https://circleci.com/api/v2/project/gh/ArtBubnov/euro_test_3/?limit=50&offset=5&filter=completed -H 'Circle-Token: 7a87730dbe7ce5fdc8b4c5129bf095ad2d6d954a'

echo $TEST
#curl -H "Circle-Token: 7a87730dbe7ce5fdc8b4c5129bf095ad2d6d954a" https://circleci.com/api/v2/project/gh/ArtBubnov/euro_test_3/$CIRCLE_BUILD_NUM/artifacts \
#        | grep -o "https://[^"]*" \
#        | wget --verbose --header "Circle-Token: $CIRCLE_TOKEN" --input-file -

#cat $TEST

#echo "------------"