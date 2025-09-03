#!/bin/bash

adb pull "/sdcard/Figures/$(adb shell 'ls -t /sdcard/Figures/' | head -1 | tr -d '\r')" ~/lecture-notes/temp.jpg

jpegtran -rotate 90 -outfile ~/lecture-notes/temp.jpg ~/lecture-notes/temp.jpg
