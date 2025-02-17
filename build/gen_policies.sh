#!/bin/bash

jq -s '.[0] * .[1]' build/policies/policies-core.json build/policies/blocklist-spec.json > build/policies/temp1.json

jq -s '.[0] * .[1]' build/policies/temp1.json build/policies/cookies-spec.json > build/policies/temp2.json

rm -f build/policies/temp1.json

jq -s '.[0] * .[1]' build/policies/temp2.json build/policies/policies-phoenix.json > policies.json

rm -f build/policies/temp2.json

python build/convert_json_to_plist.py policies.json macos/org.mozilla.nightly.plist
