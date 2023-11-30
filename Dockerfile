FROM apache/hive:3.1.3


##########################################################
# Setting default enviroment variables for local testing #
ENV DATABASE_HOST='test-db-hive-metastore'
ENV DATABASE_PORT='5432'
ENV DATABASE_DB='hive_metastore'
ENV DATABASE_USER='hive'
ENV DATABASE_PASSWORD='hive'

###########
# STORAGE #
ENV GOOGLE_APPLICATION_CREDENTIALS=/etc/secrets/key-storage.json

##########################
# Install Linux packages #
USER root
RUN apt-get update
RUN apt-get install -y gettext-base curl postgresql-client

############################
# Coping Java dependencies #
USER hive
COPY --chown=hive ./dependecies/. /opt/hive/lib/

###############
# Hive config #
# Coping template configuration
COPY --chown=hive ./conf_templates /conf_templates
# Clear original configuration
RUN rm /opt/hive/conf/hive-site.xml

# Coping configuration
COPY --chown=hive ./conf/. /opt/hive/conf/

###############################################
# Adjust entrypoint and put hive start on CMD #
COPY --chown=hive ./scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Wait for postgres backend to be available
COPY --chown=hive ./scripts/wait-for-postgres.sh /wait-for-postgres.sh
RUN chmod +x /wait-for-postgres.sh
