FROM valkey/valkey:8.1.1-alpine

COPY ./start_valkey.sh /usr/local/bin/

EXPOSE 6379
CMD ["start_valkey.sh"]
