#!/bin/bash

set -e

# Check if we're being triggered by a pull request.
PULL_REQUEST_NUMBER=$(jq .number "$GITHUB_EVENT_PATH")

# If this is a PR and Netlify is configured, plan to check the deploy preview and generate its unique URL.
# Otherwise, simply check the provided live URL.
if [ -n "$INPUT_NETLIFY_SITE" ] && [ -n "$PULL_REQUEST_NUMBER" ] && [ "$PULL_REQUEST_NUMBER" != "null" ]; then
  REPORT_URL="https://deploy-preview-${PULL_REQUEST_NUMBER}--${INPUT_NETLIFY_SITE}"
else
  REPORT_URL=${INPUT_URL}
fi

# Prepare directory for audit results and sanitize URL to a valid and unique filename.
OUTPUT_FOLDER="report"
OUTPUT_FILENAME=$(echo "$REPORT_URL" | sed 's/[^a-zA-Z0-9]/_/g')
OUTPUT_PATH="./$OUTPUT_FOLDER/$OUTPUT_FILENAME"
mkdir "$OUTPUT_FOLDER"

# Clarify in logs which URL we're auditing.
printf "* Beginning audit of %s ...\n\n" "$REPORT_URL"

# Run Lighthouse!
lighthouse --port=9222 --chrome-flags="--headless --disable-gpu --no-sandbox --no-zygote" --output "html" --output "json" --output-path "${OUTPUT_PATH}" "${REPORT_URL}"

# Parse individual scores from JSON output.
# Unorthodox jq syntax because of dashes -- https://github.com/stedolan/jq/issues/38
SCORE_PERFORMANCE=$(jq '.categories["performance"].score' "$OUTPUT_PATH".report.json)
SCORE_ACCESSIBILITY=$(jq '.categories["accessibility"].score' "$OUTPUT_PATH".report.json)
SCORE_PRACTICES=$(jq '.categories["best-practices"].score' "$OUTPUT_PATH".report.json)
SCORE_SEO=$(jq '.categories["seo"].score' "$OUTPUT_PATH".report.json)
SCORE_PWA=$(jq '.categories["pwa"].score' "$OUTPUT_PATH".report.json)

# Print scores to standard output (0 to 100 instead of 0 to 1).
# Using hacky bc b/c bash hates floating point arithmetic...
printf "\n* Completed audit of %s !" "$REPORT_URL"
printf "\n* Scores are printed below and detailed results are saved in ./report\n\n"
printf "%s\n" "+-------------------------------+"
printf "|  Performance:           %.0f\t|\n" "$(echo "$SCORE_PERFORMANCE*100" | bc -l)"
printf "|  Accessibility:         %.0f\t|\n" "$(echo "$SCORE_ACCESSIBILITY*100" | bc -l)"
printf "|  Best Practices:        %.0f\t|\n" "$(echo "$SCORE_PRACTICES*100" | bc -l)"
printf "|  SEO:                   %.0f\t|\n" "$(echo "$SCORE_SEO*100" | bc -l)"
printf "|  Progressive Web App:   %.0f\t|\n" "$(echo "$SCORE_PWA*100" | bc -l)"
printf "%s\n" "+-------------------------------+"

exit 0
