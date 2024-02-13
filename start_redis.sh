#!/bin/sh

echo "Redis server setup in progress..."

# Swap space setup (if enabled)
if [ "$SWAP" = "1" ]; then
  echo "Activating swap space..."
  SWAP_SIZE=${SWAP_SIZE:-512M}
  fallocate -l $SWAP_SIZE /swapfile && chmod 0600 /swapfile && mkswap /swapfile
  echo 10 > /proc/sys/vm/swappiness && swapon /swapfile
  echo 1 > /proc/sys/vm/overcommit_memory
  echo "Swap space activated."
fi

# Prepare Redis configuration directory
mkdir -p /etc/redis/
REDIS_CONF="/etc/redis/redis.conf"

# Configure Redis settings
{
  echo "Setting up Redis..."
  echo "bind * -::*"
  echo "requirepass ${REDIS_PASSWORD}"
  echo "timeout 0"
  echo "tcp-keepalive 300"
  echo "port ${REDIS_PORT:-6379}"
  echo "${EXTRA_REDIS_CONFIG:-# Custom Redis config here}"
} > $REDIS_CONF

# Start Redis with new configuration
echo "Starting Redis..."
redis-server $REDIS_CONF
echo "Redis is up and running!"
