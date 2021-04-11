FROM alpine:3.12.0

RUN apk add --no-cache tcpdump && \
  apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ aws-cli

ADD entrypoint.sh /files/

#COPY ./testing.pub /root/.ssh/authorized_keys
RUN ls -lrt /files/entrypoint.sh
RUN chmod +x /files/entrypoint.sh
RUN ls -lrt /files/entrypoint.sh

CMD [ "/files/entrypoint.sh" ]
