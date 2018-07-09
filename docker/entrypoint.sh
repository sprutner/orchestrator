#!/bin/sh
if [ ! -e /etc/orchestrator.conf.json ] ; then
cat <<EOF > /etc/orchestrator.conf.json
{
  "Debug": true,
  "ListenAddress": ":3000",
  "MySQLTopologyUser": "${ORC_TOPOLOGY_USER:-orchestrator}",
  "MySQLTopologyPassword": "${ORC_TOPOLOGY_PASSWORD:-orchestrator}",
  "MySQLOrchestratorHost": "${ORC_DB_HOST:-db}",
  "MySQLOrchestratorPort": ${ORC_DB_PORT:-3306},
  "MySQLOrchestratorDatabase": "${ORC_DB_NAME:-orchestrator}",
  "MySQLOrchestratorUser": "${ORC_USER:-orc_server_user}",
  "MySQLOrchestratorPassword": "${ORC_PASSWORD:-orc_server_password}"
}
EOF
fi

# if [ "$USE_KMS" = "negative" ] ; then
#   export SQL_PW=$(/kms-decrypt -s $SQL_KMS_SECRET )
#   sed -i 's/PLACEHOLDER/$SQL_PW' /usr/local/orchestrator/orchestrator.conf.json
# fi

# if [ -v SQL_USER_PASSWORD ] ; then
sed -i 's/"PLACEHOLDER",/$SQL_PW/' /usr/local/orchestrator/orchestrator.conf.json
# fi

exec /usr/local/orchestrator/orchestrator http
