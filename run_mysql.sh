#!/bin/bash

# MySQL container Setup Script
# This script spins up a MySQL container with common configurations

CONTAINER_NAME="mysql-dev-8.0"
MYSQL_ROOT_PASSWORD="rootpassword"
MYSQL_DATABASE="mydb"
MYSQL_USER="user"
MYSQL_PASSWORD="password"
MYSQL_PORT="3306"
MYSQL_VERSION="8.0"

echo "Starting MySQL container container..."

# Check if container already exists
if [ "$(container list -aq | grep $CONTAINER_NAME)" ]; then
    echo "Container '$CONTAINER_NAME' already exists."
    if [ "$(container list -q | grep $CONTAINER_NAME)" ]; then
        echo "Container is already running."
    else
        echo "Starting existing container..."
        container start $CONTAINER_NAME
    fi
else
    echo "Creating new MySQL container..."
    container run -d \
        --name $CONTAINER_NAME \
        -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
        -e MYSQL_DATABASE=$MYSQL_DATABASE \
        -e MYSQL_USER=$MYSQL_USER \
        -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
        -p $MYSQL_PORT:3306 \
        -v mysql-data-$MYSQL_VERSION:/var/lib/mysql \
        mysql:$MYSQL_VERSION
fi

echo ""
echo "MySQL container is running!"
echo "================================"
echo "Container name: $CONTAINER_NAME"
echo "Port: $MYSQL_PORT"
echo "Root password: $MYSQL_ROOT_PASSWORD"
echo "Database: $MYSQL_DATABASE"
echo "User: $MYSQL_USER"
echo "Password: $MYSQL_PASSWORD"
echo "================================"
echo ""
echo "To interact with container bash:"
echo "  container exec -it $CONTAINER_NAME bash"
echo ""
echo "To connect to MySQL directly:"
echo "  container exec -it $CONTAINER_NAME mysql -u root -p$MYSQL_ROOT_PASSWORD"
echo ""
echo "Or connect from host:"
echo "  mysql -h 127.0.0.1 -P $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASSWORD"
echo "  mysql -h 127.0.0.1 -P $MYSQL_PORT -u root -p$MYSQL_ROOT_PASSWORD"
