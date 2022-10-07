
export $(grep -v '^#' .secrets | xargs)

if [ -z ${JIRA_TOKEN+x} ]
then
   echo "Add JIRA_TOKEN to .secrets"
fi

if [ -z ${JIRA_URL+x} ]
then
   echo "Add JIRA_URL to .secrets"
fi

./airbyte-local.sh \
   --src 'farosai/airbyte-faros-feeds-source' \
   --src.api_token "$JIRA_TOKEN" \
   --src.domain "$JIRA_URL" \
   --src.startDate "2022-01-01T00:00:00Z" \
   --dst 'farosai/airbyte-faros-destination' \
   --dst.edition_configs.edition 'community' \
   --dst.edition_configs.hasura_admin_secret 'admin' \
   --dst.edition_configs.hasura_url 'http://host.docker.internal:8080/' \
   --state state.json \
   --check-connection \
   # --src-only \
   --debug
