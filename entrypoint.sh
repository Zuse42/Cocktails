#!/bin/bash
# docker entrypoint script.

# assign a default for the database_user
DB_USER_=${DB_USER:-postgres}


# wait until Postgres is ready
while ! pg_isready -q -h $DB_HOST -p 5432 -U $DB_USER_
do
    echo "$(date) - waiting for database to start!"
    sleep 2
done

bin="/app/bin/video"
eval "$bin eval \"Video.Release.migrate\""
# start the elixir application
exec "$bin" "start"
