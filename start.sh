#!/bin/bash

echo "Waiting for Cassandra to be ready on $CASSANDRA_HOST $CASSANDRA_PORT..."
sleep 5

echo "Running init.cql..."
cqlsh $CASSANDRA_HOST $CASSANDRA_PORT -u cassandra -p cassandra -f /init.cql

if [ $? -eq 0 ]; then
    echo "✅ Initialization completed successfully"
else
    echo "❌ Initialization failed"
    exit 1
fi

echo "Init container will now stop"