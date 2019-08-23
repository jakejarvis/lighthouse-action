#!/bin/bash

set -e

mkdir report

lighthouse --port=9222 --chrome-flags="--headless --disable-gpu --no-sandbox --no-zygote" --output "html" --output "json" --output-path "report/lighthouse" ${INPUT_URL}


#  $@
