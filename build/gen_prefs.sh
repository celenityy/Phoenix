#!/bin/bash

cat build/prefs/phoenix-core.js build/prefs/etp-strict.js > build/prefs/temp.js

cat build/prefs/temp.js build/prefs/phoenix-android.js > prefs/phoenix-android.js

rm build/prefs/temp.js

cat prefs/phoenix-android.js build/prefs/extended/phoenix-extended-core.js > build/prefs/extended-temp.js

cat build/prefs/extended-temp.js build/prefs/extended/phoenix-extended-android.js > prefs/phoenix-extended-android.js

rm build/prefs/extended-temp.js

cat build/prefs/phoenix-core.js build/prefs/phoenix-desktop-common.js > build/prefs/temp.js

cat build/prefs/temp.js build/prefs/phoenix-desktop.js > prefs/phoenix-desktop.js

rm build/prefs/temp.js

cat prefs/phoenix-desktop.js build/prefs/extended/phoenix-extended-core.js > build/prefs/temp1.js

cat build/prefs/temp1.js build/prefs/extended/phoenix-extended-desktop-common.js > build/prefs/temp2.js

rm build/prefs/temp1.js

cat build/prefs/temp2.js build/prefs/extended/phoenix-extended-desktop.js > prefs/phoenix-extended-desktop.js

rm build/prefs/temp2.js
