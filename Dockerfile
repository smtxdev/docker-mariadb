# Main Dockerfile. Only edit this Dockerfile.
# If you make changes here then copy this file over to all other folders which contain a Dockerfile.
# Make sure you just change the ARG instruction in the other Dockerfiles.
# And of course do not copy this comment into the other Dockerfiles.
ARG MARIADB_VERSION=latest
FROM mariadb:${MARIADB_VERSION}
ENV TZ "Europe/Berlin"
ADD ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["mysqld"]
