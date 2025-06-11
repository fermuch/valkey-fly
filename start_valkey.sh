#!/bin/sh

SWAP_SIZE=${SWAP_SIZE:-512M}

if [ "$SWAP" = "1" ]; then
  echo "Setting up swap space..."
  fallocate -l ${SWAP_SIZE} /swapfile
  chmod 0600 /swapfile
  mkswap /swapfile
  echo 10 > /proc/sys/vm/swappiness
  swapon /swapfile
  echo 1 > /proc/sys/vm/overcommit_memory
fi

mkdir -p /etc/valkey/

VALKEY_CONF="/etc/valkey/valkey.conf"
VALKEY_PORT=${VALKEY_PORT:-6379}
VALKEY_DATA_DIR=${VALKEY_DATA_DIR:-/data/}

echo "" > $VALKEY_CONF
echo "bind * -::*" >> $VALKEY_CONF
echo "requirepass $VALKEY_PASSWORD" >> $VALKEY_CONF
echo "timeout 0" >> $VALKEY_CONF
echo "tcp-keepalive 300" >> $VALKEY_CONF
echo "port $VALKEY_PORT" >> $VALKEY_CONF

## STORAGE
# save every 15 min if ≥1 write
echo "save 900 1" >> $VALKEY_CONF
# save every 5 min if ≥10 writes
echo "save 300 10" >> $VALKEY_CONF
# save every 1 min if ≥10000 writes
echo "save 60  10000" >> $VALKEY_CONF

## DATA DIRECTORY
echo "dir $VALKEY_DATA_DIR" >> $VALKEY_CONF
echo "dbfilename dump.rdb" >> $VALKEY_CONF

## APPEND ONLY FILE
echo "appendonly yes" >> $VALKEY_CONF
echo "appendfilename appendonly.aof" >> $VALKEY_CONF
echo "appendfsync everysec" >> $VALKEY_CONF
echo "auto-aof-rewrite-percentage 100" >> $VALKEY_CONF
echo "auto-aof-rewrite-min-size 64mb" >> $VALKEY_CONF
echo "aof-load-truncated yes" >> $VALKEY_CONF

## MEMORY LIMITS
echo "maxmemory 1gb" >> $VALKEY_CONF
echo "maxmemory-policy volatile-lfu" >> $VALKEY_CONF
echo "maxmemory-samples 5" >> $VALKEY_CONF

## EXTRA CONFIG
echo "$EXTRA_VALKEY_CONFIG" >> $VALKEY_CONF

valkey-server $VALKEY_CONF