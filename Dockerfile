FROM n8nio/n8n:latest
USER root
RUN wget -qO /tmp/docker.tgz https://download.docker.com/linux/static/stable/aarch64/docker-27.0.3.tgz \
    && tar -xz -f /tmp/docker.tgz -C /tmp/ \
    && mv /tmp/docker/docker /usr/local/bin/docker \
    && chmod +x /usr/local/bin/docker \
    && rm -rf /tmp/docker /tmp/docker.tgz \
    && mkdir -p /usr/local/lib/docker/cli-plugins \
    && wget -qO /usr/local/lib/docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-aarch64 \
    && chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
USER node