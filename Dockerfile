FROM node:10-slim

LABEL "com.github.actions.name"="Lighthouse Audit"
LABEL "com.github.actions.description"="Run tests on a webpage via Google's Lighthouse tool"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="yellow"

LABEL version="0.1.0"
LABEL repository="https://github.com/jakejarvis/lighthouse-action"
LABEL homepage="https://jarv.is/"
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

# Install and upgrade utilities
RUN apt-get update --fix-missing && apt-get -y upgrade

# Install latest Chrome stable (and jq for later JSON parsing -- https://stedolan.github.io/jq/)
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable jq bc --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

# Download latest Lighthouse build from npm
# Cache bust to ensure latest version when building the image
ARG CACHEBUST=1
RUN npm install -g lighthouse

# Disable Lighthouse error reporting to prevent prompt
ENV CI=true

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
