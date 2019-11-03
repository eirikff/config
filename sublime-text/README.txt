This folder is for all custom Sublime Text 3 files.

To use them, create a symlink to the `Sublime Text 3/Packages/User`
directory and Sublime Text will be able to read and write to them.

This changes settings and themes across devices.

----------------------------------------------------------------------------

For OS X:
ln -s "${HOME}/Google Drive/Development/Sublime Text/Preferences.sublime-settings" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/"
ln -s "${HOME}/Google Drive/Development/Sublime Text/8-Colour-Dark.tmTheme" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/"

For Linux:
[tbd]
	
For Windows:
mklink "C:\Users\eirik\AppData\Roaming\Sublime Text 3\Packages\User\Preferences.sublime-settings" "C:\Users\eirik\Google Drive\Development\Sublime Text\Preferences.sublime-settings"
mklink "C:\Users\eirik\AppData\Roaming\Sublime Text 3\Packages\User\8-Colour-Dark.tmTheme" "C:\Users\eirik\Google Drive\Development\Sublime Text\8-Colour-Dark.tmTheme"

