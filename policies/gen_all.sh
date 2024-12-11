#!/bin/bash

jq -s '.[0] * .[1]' policies/Policies/base-policies.json policies/Blocklist/blocklist.json > policies/Policies/temp.json

jq -s '.[0] * .[1]' policies/Policies/temp.json policies/Blocklist/cookies.json > policies/Policies/policies.json

rm -f policies/Policies/temp.json

jq -s '.[0] * .[1]' policies/Policies/policies.json policies/No-Sync/policies-specific.json > policies/No-Sync/policies.json

jq -s '.[0] * .[1]' policies/Policies/policies.json policies/Personal/policies-specific.json > policies/Personal/policies.json

# Replace ~/Projects/Phoenix-Policies-Debian with the directory where Phoenix-Policies-Debian is located, otherwise you can comment this section out
cp policies/Policies/policies.json ~/Projects/Phoenix-Policies-Debian/phoenix-policies/policies.json

cp policies/No-Sync/policies.json ~/Projects/Phoenix-Policies-Debian/phoenix-policies-no-sync/policies.json

cp policies/Personal/policies.json ~/Projects/Phoenix-Policies-Debian/phoenix-policies-personal/policies.json