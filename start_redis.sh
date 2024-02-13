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

mkdir -p /etc/redis/

REDIS_CONF="/etc/redis/redis.conf"
REDIS_PORT=${REDIS_PORT:-6379}

echo "" > $REDIS_CONF
echo "bind * -::*" >> $REDIS_CONF
echo "requirepass $REDIS_PASSWORD" >> $REDIS_CONF
echo "timeout 0" >> $REDIS_CONF
echo "tcp-keepalive 300" >> $REDIS_CONF
echo "port $REDIS_PORT" >> $REDIS_CONF
echo "$EXTRA_REDIS_CONFIG" >> $REDIS_CONF

redis-server $REDIS_CONF