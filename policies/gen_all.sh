#!/bin/bash

jq -s '.[0] * .[1]' policies/Linux/Policies/base-policies.json policies/Blocklist/blocklist.json > policies/Linux/Policies/temp.json

jq -s '.[0] * .[1]' policies/Linux/Policies/temp.json policies/Blocklist/cookies.json > policies/Linux/Policies/policies.json

rm -f policies/Linux/Policies/temp.json

jq -s '.[0] * .[1]' policies/Linux/Policies/policies.json policies/Policies/policies-specific.json > policies/Policies/policies.json

jq -s '.[0] * .[1]' policies/Linux/Policies/policies.json policies/No-Sync/policies-specific.json > policies/Linux/No-Sync/policies.json

jq -s '.[0] * .[1]' policies/Linux/No-Sync/policies.json policies/Policies/policies-specific.json > policies/No-Sync/policies.json

jq -s '.[0] * .[1]' policies/Linux/Policies/policies.json policies/Personal-Policies/policies-specific.json > policies/Linux/Personal-Policies/policies.json

jq -s '.[0] * .[1]' policies/Linux/Personal-Policies/policies.json policies/Policies/policies-specific.json > policies/Personal-Policies/temp.json

jq -s '.[0] * .[1]' policies/Personal-Policies/temp.json policies/Personal-Policies/enforce-updating.json > policies/Personal-Policies/policies.json

rm -f policies/Personal-Policies/temp.json

jq -s '.[0] * .[1]' policies/Linux/Personal-Policies/policies.json policies/No-Sync/policies-specific.json > policies/Linux/Personal-Dev-Nightly-Policies/temp.json

jq -s '.[0] * .[1]' policies/Linux/Personal-Dev-Nightly-Policies/temp.json policies/Personal-Dev-Nightly-Policies/policies-specific.json > policies/Linux/Personal-Dev-Nightly-Policies/policies.json

rm -f policies/Linux/Personal-Dev-Nightly-Policies/temp.json

jq -s '.[0] * .[1]' policies/Linux/Personal-Dev-Nightly-Policies/policies.json policies/Policies/policies-specific.json > policies/Personal-Dev-Nightly-Policies/temp.json

jq -s '.[0] * .[1]' policies/Personal-Dev-Nightly-Policies/temp.json policies/Personal-Policies/enforce-updating.json > policies/Personal-Dev-Nightly-Policies/policies.json

rm -f policies/Personal-Dev-Nightly-Policies/temp.json

# Replace ~/Projects/Phoenix-Policies-Fedora with the directory where Phoenix-Policies-Fedora is located, otherwise you can comment this out
cp policies/Linux/Policies/policies.json ~/Projects/Phoenix-Policies-Fedora/standard/policies.json

cp policies/Linux/No-Sync/policies.json ~/Projects/Phoenix-Policies-Fedora/no-sync/policies.json

cp policies/Linux/Personal-Policies/policies.json ~/Projects/Phoenix-Policies-Fedora/personal/policies.json

cp policies/Linux/Personal-Dev-Nightly-Policies/policies.json ~/Projects/Phoenix-Policies-Fedora/personal-dev-nightly/policies.json

# Replace ~/Projects/Phoenix-Policies-Debian with the directory where Phoenix-Policies-Debian is located, otherwise you can comment this out
cp policies/Linux/Policies/policies.json ~/Projects/Phoenix-Policies-Debian/phoenix-policies/policies.json

cp policies/Linux/No-Sync/policies.json ~/Projects/Phoenix-Policies-Debian/phoenix-policies-no-sync/policies.json

cp policies/Linux/Personal-Policies/policies.json ~/Projects/Phoenix-Policies-Debian/phoenix-policies-personal/policies.json