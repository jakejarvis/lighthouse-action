#!/bin/bash

set -e

mkdir report

lighthouse --port=9222 --chrome-flags="--headless --disable-gpu --no-sandbox --no-zygote" --output "html" --output "json" --output-path "report/lighthouse" ${INPUT_URL}

# Parse individual scores from JSON output
# Unorthodox jq syntax because of dashes -- https://github.com/stedolan/jq/issues/38
SCORE_PERFORMANCE=$(cat ./report/lighthouse.report.json | jq '.categories["performance"].score')
SCORE_ACCESSIBILITY=$(cat ./report/lighthouse.report.json | jq '.categories["accessibility"].score')
SCORE_PRACTICES=$(cat ./report/lighthouse.report.json | jq '.categories["best-practices"].score')
SCORE_SEO=$(cat ./report/lighthouse.report.json | jq '.categories["seo"].score')
SCORE_PWA=$(cat ./report/lighthouse.report.json | jq '.categories["pwa"].score')

# Print scores to standard output (out of 100 instead of 0 to 1)
printf "Performance: %.0f\n" $((SCORE_PERFORMANCE*100))
printf "Accessibility: %.0f\n" $((SCORE_ACCESSIBILITY*100))
printf "Best Practices: %.0f\n" $((SCORE_PRACTICES*100))
printf "SEO: %.0f\n" $((SCORE_SEO*100))
printf "Progressive Web App: %.0f\n" $((SCORE_PWA*100))

exit 0
