#!/bin/bash

jq -s '.[0] * .[1]' build/policies/policies-spec.json build/policies/blocklist-spec.json > build/policies/temp.json

jq -s '.[0] * .[1]' build/policies/temp.json build/policies/cookies-spec.json > policies.json

rm -f build/policies/temp.json

jq -s '.[0] * .[1]' policies.json build/policies/personal-spec.json > personal-policies/policies.json
