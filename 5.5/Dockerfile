# Do not change anything here except ARG. Real changes only in the main Dockerfile.
ARG MARIADB_VERSION=5.5
FROM mariadb:${MARIADB_VERSION}
ENV TZ "Europe/Berlin"
ADD ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["mysqld"]
