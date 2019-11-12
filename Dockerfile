# Builds images for 781127743430.dkr.ecr.us-east-1.amazonaws.com/infra/syslog-logstash-forwarder
FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y -qq \
    wget \
    git-core \
    python3-pip \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    && \
    rm -rf \
    /var/lib/apt \
    /var/cache/apt

# Used to evaluate tpl config files
RUN pip3 install \
    mkdocs \
    mkpdfs-mkdocs

# Install dumb init
ENV DUMB_INIT_VERSION 1.2.2
RUN wget -q https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
    -O /usr/local/bin/dumb-init && \
    chmod +x /usr/local/bin/dumb-init

# Where to place Markdown-source and generated HTML files.
RUN mkdir -p /mkdocs/css
RUN mkdir -p /mkdocs/docs
# VOLUME /mkdocs/docs
# VOLUME /mkdocs/site
COPY src/mkdocs.yml /mkdocs/mkdocs.yml
COPY src/dead_urals.css /mkdocs/css/dead_urals.css
COPY src/init.sh /mkdocs/init.sh

WORKDIR /mkdocs
EXPOSE 8000

CMD [ "dumb-init", "--", "/mkdocs/init.sh" ]
