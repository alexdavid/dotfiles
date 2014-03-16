#!/bin/bash

# Mnmlsm (http://www.adiumxtras.com/index.php?a=xtras&xtra_id=7780)
open adiumxtra://www.adiumxtras.com/download/7780
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/WebKit\ Message\ Display.plist "Current Style Path" -string "~/Library/Application Support/Adium 2.0/Message Styles/Mnmlsm.AdiumMessageStyle"
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/WebKit\ Message\ Display.plist "Message Style" -string "im.adium.mnmlsm.style"


# Adiumy Retina (http://www.adiumxtras.com/index.php?a=xtras&xtra_id=8329)
open adiumxtra://www.adiumxtras.com/download/8329
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/Appearance.plist "Menu Bar Icons" -string "Adiumy (Retina)"


# iTunes 7 (http://www.adiumxtras.com/index.php?a=xtras&xtra_id=3380)
open adiumxtra://www.adiumxtras.com/download/3380
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/Appearance.plist "List Layout Name" -string "iTunes 7"
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/Appearance.plist "List Theme Name" -string "iTunes 7"


# iPhone mini (http://www.adiumxtras.com/index.php?a=xtras&xtra_id=4115)
open adiumxtra://www.adiumxtras.com/download/4115
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/Appearance.plist "Status Icon Pack" -string "iPhone (mini)"


# No emoticons
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/Emoticons.plist "Active Emoticon Packs" -array


# Dock icon
defaults write ~/Library/Application\ Support/Adium\ 2.0/Users/Default/Appearance.plist "Dock Icon" -string "Adiumy Black"
