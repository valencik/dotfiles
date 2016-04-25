sudo scutil --set ComputerName "andrew-rMBP"
sudo scutil --set HostName "andrew-rMBP"
sudo scutil --set LocalHostName "andrew-rMBP"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "andrew-rMBP"
