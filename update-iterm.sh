cp .plists/com.googlecode.iterm2.plist.xml1 .plists/com.googlecode.iterm2.plist 
plutil -convert binary1 .plists/com.googlecode.iterm2.plist
mv .plists/com.googlecode.iterm2.plist ~/Library/Preferences/
