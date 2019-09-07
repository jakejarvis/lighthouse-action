# Base image built from Dockerfile.base (Chrome Stable + Node LTS)
FROM jakejarvis/chrome-headless:latest

LABEL "com.github.actions.name"="Lighthouse Audit" \
    "com.github.actions.description"="Run tests on a webpage via Google's Lighthouse tool" \
    "com.github.actions.icon"="check-square" \
    "com.github.actions.color"="yellow" \
    version="0.2.0" \
    repository="https://github.com/jakejarvis/lighthouse-action" \
    homepage="https://jarv.is/" \
    maintainer="Jake Jarvis <jake@jarv.is>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
