echo "Deploy data to Dev Env"

echo "variables test"
EVENT_TYPE=<< pipeline.parameters.eventType >>
EVENT_TYPE=<< pipeline.parameters.branchName >>
EVENT_TYPE=<< pipeline.parameters.sourceBranchName >>

echo $EVENT_TYPE
echo $BRANCH_NAME
echo $SOURCE_BRANCH_NAME

echo "Find the difference between organizations"
#PATH_FILTER="./"
#UPDATED_FILES=$(git diff --name-only origin/dev force-app)
#echo "What is the diff?"
#echo $UPDATED_FILES