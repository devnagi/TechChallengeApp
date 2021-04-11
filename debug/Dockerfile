FROM alpine:3.12.0

RUN apk add --no-cache tcpdump && \
  apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ aws-cli

ADD debug/entrypoint.sh /files/

# Configure the importing of all environment variables from pid 1 to make use of the ECS specific environment variables(Task Roles) for the awscli
RUN echo 'export $(strings /proc/1/environ)' > /root/.profile && \
# Changing the motd to remember the above configuration
  printf '\n\nNOTICE: export $(strings /proc/1/environ) is run on the ash shell profile which makes the aws cli work with Task Roles.\nc' > /etc/motd

RUN ls -lrt /files/entrypoint.sh
RUN chmod +x /files/entrypoint.sh
RUN ls -lrt /files/entrypoint.sh

CMD [ "/files/entrypoint.sh" ]
