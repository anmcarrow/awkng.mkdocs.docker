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
    apt-get remove -yq \
       build-essential \
       gcc gcc-8 cpp cpp-8 \
       libgcc-8-dev dpkg-dev \
       libc-dev-bin libc6-dev \
       libexpat1-dev \ 
       libgcc-8-dev \ 
       libpython3-dev \
       libpython3.7-dev \ 
       libstdc++-8-dev \ 
       linux-libc-dev \ 
       manpages-dev \ 
       python3-dev \ 
       python3.7-dev \
       manpages \ 
       manpages-dev \
    && \
    rm -rf /root/.cache \
    && \
    rm -rf \
    /var/lib/apt \
    /var/cache/apt

RUN pip3 install \
    mkdocs \
    mkpdfs-mkdocs


# Install dumb init
ENV DUMB_INIT_VERSION 1.2.2
RUN wget -q https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
    -O /usr/local/bin/dumb-init && \
    chmod +x /usr/local/bin/dumb-init

# Where to place Markdown-source and generated HTML files.
RUN useradd --system --home /mkdocs web
RUN mkdir -p /mkdocs/css \
    && mkdir -p /mkdocs/docs

COPY src/conf /mkdocs
COPY src/scripts /mkdocs
COPY src/css /mkdocs/css

RUN  chown -R web:web /mkdocs

USER web
WORKDIR /mkdocs
EXPOSE 8000

CMD [ "dumb-init", "--", "/mkdocs/init.sh" ]
