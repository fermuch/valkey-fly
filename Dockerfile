FROM redis:7.0.12-alpine

COPY ./start_redis.sh /usr/local/bin/

EXPOSE 6379
CMD ["start_redis.sh"]
