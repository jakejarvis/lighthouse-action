FROM node:lts-slim

LABEL repository="https://github.com/jakejarvis/chrome-headless-docker"
LABEL homepage="https://jarv.is/"
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

ARG DEBIAN_FRONTEND=noninteractive

# Install and upgrade required utilities
RUN apt-get update -qqy && \
    apt-get install -qqy --no-install-recommends gnupg2 wget ca-certificates apt-transport-https && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install latest Chrome stable
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update -qqy && \
    apt-get install -qqy --no-install-recommends google-chrome-stable && \
    rm /etc/apt/sources.list.d/google-chrome.list && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Start Chrome in headless/debugging mode by default
ENTRYPOINT ["/usr/bin/google-chrome-stable", \
            "--headless", \
            "--no-sandbox", \
            "--no-zygote", \
            "--disable-gpu", \
            "--disable-dev-shm-usage", \
            "--remote-debugging-address=0.0.0.0", \
            "--remote-debugging-port=9222"]
