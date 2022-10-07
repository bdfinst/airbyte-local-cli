
export $(grep -v '^#' .env | xargs)

if [ -z ${JIRA_TOKEN+x} ]
then
   echo "Add JIRA_TOKEN to .env"
fi

if [ -z ${JIRA_URL+x} ]
then
   echo "Add JIRA_URL to .env"
fi

./airbyte-local.sh \
   --src 'farosai/airbyte-faros-feeds-source' \
   --src.api_token "$JIRA_TOKEN" \
   --src.domain "$JIRA_URL" \
   --src.startDate "2022-01-01T00:00:00Z" \
   --dst 'farosai/airbyte-faros-destination' \
   --dst.edition_configs.edition 'community' \
   --dst.edition_configs.hasura_admin_secret 'admin' \
   --dst.edition_configs.hasura_url 'http://localhost:8080' \
   --state state.json \
   --check-connection \
   --src-only \
   --debug
