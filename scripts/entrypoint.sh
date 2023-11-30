#!/bin/bash
echo "# Checking if Postgres is available"
source /wait-for-postgres.sh

set -x
# Set service and Database Driver
DB_DRIVER="postgres"
SERVICE_NAME="metastore"
export HIVE_CONF_DIR=$HIVE_HOME/conf

###################################
# Ajusting template configuration #
echo "# Replacing env variable on conf_templates/hive-site.xml"
envsubst < /conf_templates/hive-site.xml > $HIVE_CONF_DIR/hive-site.xml

##################################################################
# This file is a modification of the original entrypoint.sh from #
# hive official image #
if [ -d "${HIVE_CUSTOM_CONF_DIR:-}" ]; then
  find "${HIVE_CUSTOM_CONF_DIR}" -type f -exec \
    ln -sfn {} "${HIVE_CONF_DIR}"/ \;
  export HADOOP_CONF_DIR=$HIVE_CONF_DIR
  export TEZ_CONF_DIR=$HIVE_CONF_DIR
fi

echo "# Migrate schema if not exists"
export HADOOP_CLIENT_OPTS="$HADOOP_CLIENT_OPTS -Xmx1G $SERVICE_OPTS"
{
    $HIVE_HOME/bin/schematool -dbType $DB_DRIVER -initSchema -ifNotExists
} || {
  echo "! Error migrating database, probably it was already initiated..."
}


echo "# Stating Hive Metastore"
export METASTORE_PORT=${METASTORE_PORT:-9083}
exec $HIVE_HOME/bin/hive --skiphadoopversion --skiphbasecp --service $SERVICE_NAME
