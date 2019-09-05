#!/bin/bash

set -e

mkdir report

# In case of push event this might be empty
PULL_REQUEST_NUMBER=$(jq .number ${GITHUB_EVENT_PATH})

if [ -n "${INPUT_NETLIFY_SITE}" ] && [ -n "${PULL_REQUEST_NUMBER}" ]
then
  # PR + Netlify enabled: generate Netlify deploy preview URL
  REPORT_URL="https://deploy-preview-${PULL_REQUEST_NUMBER}--${INPUT_NETLIFY_SITE}"
  echo "Running against Netlify Deploy Preview ${REPORT_URL}"
else
  # Fallback to default UNPUT_URL
  REPORT_URL=${INPUT_URL}
fi

lighthouse --port=9222 --chrome-flags="--headless --disable-gpu --no-sandbox --no-zygote" --output "html" --output "json" --output-path "report/lighthouse" ${REPORT_URL}

# Parse individual scores from JSON output
# Unorthodox jq syntax because of dashes -- https://github.com/stedolan/jq/issues/38
SCORE_PERFORMANCE=$(jq '.categories["performance"].score' ./report/lighthouse.report.json)
SCORE_ACCESSIBILITY=$(jq '.categories["accessibility"].score' ./report/lighthouse.report.json)
SCORE_PRACTICES=$(jq '.categories["best-practices"].score' ./report/lighthouse.report.json)
SCORE_SEO=$(jq '.categories["seo"].score' ./report/lighthouse.report.json)
SCORE_PWA=$(jq '.categories["pwa"].score' ./report/lighthouse.report.json)

# Print scores to standard output (out of 100 instead of 0 to 1)
# TO DO: Don't use hacky bc b/c bash hates floating point arithmetic
printf "%s\n" "----------------------------------"
printf "|  Performance:           %.0f\t|\n" $(echo "$SCORE_PERFORMANCE*100" | bc -l)
printf "|  Accessibility:         %.0f\t|\n" $(echo "$SCORE_ACCESSIBILITY*100" | bc -l)
printf "|  Best Practices:        %.0f\t|\n" $(echo "$SCORE_PRACTICES*100" | bc -l)
printf "|  SEO:                   %.0f\t|\n" $(echo "$SCORE_SEO*100" | bc -l)
printf "|  Progressive Web App:   %.0f\t|\n" $(echo "$SCORE_PWA*100" | bc -l)
printf "%s\n" "----------------------------------"

exit 0
