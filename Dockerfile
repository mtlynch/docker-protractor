FROM node:10-stretch
LABEL maintainer="Michael Lynch <michael@mtlynch.io>"

# Enable support for Chrome
ARG DEBIAN_FRONTEND=noninteractive
RUN set -x && \
    wget \
      --quiet \
      https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get update && \
    apt install ./google-chrome-stable_current_amd64.deb --yes

# Install protractor and dependencies.
ARG PROTRACTOR_VERSION=6.0.0
RUN set -x && \
    apt-get install --yes \
      openjdk-8-jdk \
      libgconf-2-4 && \
    apt-cache search jdk && \
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk && \
    export PATH=$PATH:/usr/lib/jvm/java-8-openjdk/bin && \
    npm install --global "protractor@${PROTRACTOR_VERSION}" && \
    webdriver-manager update

WORKDIR /app
