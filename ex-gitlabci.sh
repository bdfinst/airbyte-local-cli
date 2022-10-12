export $(grep -v '^#' .secrets | xargs)

if [ -z ${JIRA_TOKEN+x} ]; then
   echo "Add JIRA_TOKEN to .secrets"
fi

if [ -z ${JIRA_URL+x} ]; then
   echo "Add JIRA_URL to .secrets"
fi

./airbyte-local.sh \
   --src 'farosai/airbyte-faros-feeds-source' \
   --src.feed_cfg.feed_name 'gitlab-feed' \
   --src.feed_cfg.feed_path 'vcs/gitlab-feed' \
   --src.feed_cfg.api_url "${GITLAB_URL}" \
   --src.feed_cfg.token "${GITLAB_TOKEN}" \
   --src.feed_cfg.repos_query_mode.query_mode 'GitLabGroup' \
   --src.feed_cfg.group_names '["platform-one/big-bang/apps/sandbox/holocron"]' \
   --src.feed_cfg.repositories '["dev-environment"]' \
   --dst 'farosai/airbyte-faros-destination' \
   --dst.edition_configs.edition 'community' \
   --dst.edition_configs.hasura_admin_secret 'admin' \
   --dst.edition_configs.hasura_url 'http://host.docker.internal:8080/' \
   --check-connection &
   # --full-refresh \
   # --debug &

./airbyte-local.sh \
   --src 'farosai/airbyte-faros-feeds-source' \
   --src.feed_cfg.feed_name 'gitlabci-feed' \
   --src.feed_cfg.feed_path 'cicd/gitlabci-feed' \
   --src.feed_cfg.api_url "${GITLAB_URL}" \
   --src.feed_cfg.token "${GITLAB_TOKEN}" \
   --src.feed_cfg.repos_query_mode.query_mode 'GitLabGroup' \
   --src.feed_cfg.group_names '["platform-one/big-bang/apps/sandbox/holocron"]' \
   --src.feed_cfg.repositories '["dev-environment"]' \
   --dst 'farosai/airbyte-faros-destination' \
   --dst.edition_configs.edition 'community' \
   --dst.edition_configs.hasura_admin_secret 'admin' \
   --dst.edition_configs.hasura_url 'http://host.docker.internal:8080/' \
   --check-connection &
   # --full-refresh \
   # --debug &
