#!/bin/bash
set -e

until PGPASSWORD=${DATABASE_PASSWORD} psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USER" -c '\q' ${DATABASE_DB}; do
  >&2 echo "Postgres is unavailable DATABASE_HOST:${DATABASE_HOST}, DATABASE_PORT:${DATABASE_PORT}, DATABASE_USER:${DATABASE_USER} DATABASE_DB:${DATABASE_DB}: - sleeping"
  sleep 1
done
echo "Postgres Ok!!"
