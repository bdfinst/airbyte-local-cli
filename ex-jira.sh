export $(grep -v '^#' .secrets | xargs)

if [ -z ${JIRA_TOKEN+x} ]; then
   echo "Add JIRA_TOKEN to .secrets"
fi

if [ -z ${JIRA_URL+x} ]; then
   echo "Add JIRA_URL to .secrets"
fi

./airbyte-local.sh \
   --src 'farosai/airbyte-faros-feeds-source' \
   --src.feed_cfg.feed_name 'jira-feed' \
   --src.feed_cfg.feed_path 'tms/jira-feed' \
   --src.feed_cfg.domain "$JIRA_URL" \
   --src.feed_cfg.api_token "$JIRA_TOKEN" \
   --src.feed_cfg.projects_query_mode.query_mode 'ProjectList' \
   --src.feed_cfg.projects '["CLMD"]' \
   --dst 'farosai/airbyte-faros-destination' \
   --dst.edition_configs.edition 'community' \
   --dst.edition_configs.hasura_admin_secret 'admin' \
   --dst.edition_configs.hasura_url 'http://host.docker.internal:8080/' \
   --check-connection \
   # --full-refresh \
   # --debug
