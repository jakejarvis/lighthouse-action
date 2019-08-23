#!/bin/bash

set -e

lighthouse --port=9222 --chrome-flags="--headless --disable-gpu --no-sandbox --no-zygote" --output "html" --output "json" --output-path "report/report" ${INPUT_URL}


#  $@
