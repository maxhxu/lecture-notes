# Workflow

Save notes in Samsung Notes as jpg in Figures directory, then
```
adb pull "/sdcard/Figures/$(adb shell 'ls -t /sdcard/Figures/' | head -1 | tr -d '\r')" ~/lecture-notes/temp.jpg
``
to get latest file and put in lecture notes.

Then need to rotate pulled files 270 degrees, because Samsung Notes do not allow for horizontal notes yet
*Update*: now they do allow for horizontal notes but I prefer the 2:1 aspect ratio page which is only available vertically
```
jpegtran -rotate 90 -outfile ~/lecture-notes/temp.jpg ~/lecture-notes/temp.jpg
```

I still need to name the file to something other than temp though :P
