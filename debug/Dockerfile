FROM alpine:3.12.0

RUN tail /etc/apk/repositories

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
  apk update

RUN tail /etc/apk/repositories

RUN apk add --no-cache openssh tcpdump curl mtr nmap nmap-nping bind-tools nginx stress-ng jq apparmor@edge && \
  apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ aws-cli

ADD debug/entrypoint.sh /files/

# Installing/Configuring SSH for access
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
  ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa && \
  ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa && \
  ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 && \
  sed -i "s/#Port 22/Port 8022/" /etc/ssh/sshd_config && \
  mkdir /root/.ssh && \
# Temporary hack to ensure ssh keys still work
  passwd -d root && \
# Configure the importing of all environment variables from pid 1 to make use of the ECS specific environment variables(Task Roles) for the awscli
  echo 'export $(strings /proc/1/environ)' > /root/.profile && \
# Changing the motd to remember the above configuration
  printf '\n\nNOTICE: export $(strings /proc/1/environ) is run on the ash shell profile which makes the aws cli work with Task Roles.\nc' > /etc/motd

RUN ls -lrt /files/entrypoint.sh
RUN chmod +x /files/entrypoint.sh
RUN ls -lrt /files/entrypoint.sh

CMD [ "/files/entrypoint.sh" ]
