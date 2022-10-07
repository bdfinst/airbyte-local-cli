   
export $(grep -v '^#' .env | xargs)

if [ -z ${GITLAB_TOKEN+x} ]
then
   echo "Add GITLAB_TOKEN to .env"
fi

if [ -z ${GITLAB_URL+x} ]
then
   echo "Add GITLAB_URL to .env"
fi

./airbyte-local.sh \
   --src 'farosai/airbyte-gitlab-ci-source' \
   --src.token "${GITLAB_TOKEN}" \
   --src.apiUrl "${GITLAB_URL}" \
   --src.groupName 'platform-one/big-bang/apps/sandbox/holocron' \
   --src.projects '["dev-environment"]' \
   --dst 'farosai/airbyte-faros-destination' \
   --dst.edition_configs.edition 'community' \
   --dst.edition_configs.hasura_admin_secret 'admin' \
   --dst.edition_configs.hasura_url 'localhost:8080' \
   --state state.json \
   --check-connection \
   --src-only \
   --debug \
