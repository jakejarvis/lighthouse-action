# Base image built from Dockerfile.base (Chrome Stable + Node LTS)
FROM jakejarvis/chrome-headless:latest

LABEL "com.github.actions.name"="Lighthouse Audit"
LABEL "com.github.actions.description"="Run tests on a webpage via Google's Lighthouse tool"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="yellow"

LABEL version="0.2.0"
LABEL repository="https://github.com/jakejarvis/lighthouse-action"
LABEL homepage="https://jarv.is/"
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
