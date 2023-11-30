# Hive Metastore Pumpwood

It extends official Hive Metastore Image installing adding some dependencies
on Image to facilitate use on different cloud providers. Have some adjusts to
facilitate local deploy on docker-compose and eventually on K8s.

# Dependencies
JAR dependencies are available on dependencies folder, maven was used without
success to manage dependencies.

# Check image files
It is possible to navigate on docker image after build to ensure that the
files are all there.
```
source version
docker run -it --entrypoint='' andrebaceti/hive-metabase-pumpwood:$VERSION bash
```
# Run locally for tests using Trino
It is possible to run Hive Metastore with Postgres Backend and Trino using
docker-compose at `ZZZZ__test-aux/docker-compose/docker-compose.yml`

# Image ajusts
## Logs on stdout
Hive logs will be displayed on stout. This facilitates logs collection at
docker-compose and K8s.

## Wait for database to be ready
Before starting hive, process will wait for database to ready for connection
using `scripts/wait-for-postgres.sh`.

## Try to sync database on every container start
This facilitates to start hive with empty PostgreSQL as back-end. This will
take a little more time for container start (few seconds), but will remove
hours of work for devops people... fair trade.
