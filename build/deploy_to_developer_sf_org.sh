echo "Deploy data to Dev Env"

echo "variables test"

echo $EVENT_TYPE
echo $BRANCH_NAME
echo $SOURCE_BRANCH_NAME

echo "Find the difference between organizations"
PATH_FILTER="./"
UPDATED_FILES=$(git diff --name-only origin/qa force-app)
echo "What is the diff?"
echo $UPDATED_FILES

echo 'export UPDATED_FILES_GLOBAL=$UPDATED_FILES' >> "$BASH_ENV"