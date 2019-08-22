#!/bin/bash

set -e

lighthouse --port=9222 --chrome-flags="--headless --disable-gpu --no-sandbox --no-zygote" $@
