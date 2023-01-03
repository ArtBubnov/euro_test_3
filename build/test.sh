echo -e "test\n\n\n"
CIRCLE_TOKEN=7a87730dbe7ce5fdc8b4c5129bf095ad2d6d954a
TEST=curl -H "Circle-Token: $CIRCLE_TOKEN" https://circleci.com/api/v2/project/gh/ArtBubnov/euro_test_3/$CIRCLE_BUILD_NUM/artifacts \
        | grep -o "https://[^"]*" \
        | wget --verbose --header "Circle-Token: $CIRCLE_TOKEN" --input-file -

cat $TEST

echo "------------"