#!/bin/bash

cat build/prefs/phoenix-core.js build/prefs/etp-strict.js > build/prefs/temp.js

cat build/prefs/temp.js build/prefs/phoenix-android.js > prefs/phoenix-android.js

rm build/prefs/temp.js

cat build/prefs/extended/phoenix-extended-core.js build/prefs/extended/phoenix-extended-android.js > prefs/phoenix-extended-android.js
