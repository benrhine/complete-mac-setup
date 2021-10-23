#!/usr/bin/env bash

# NOTE: THIS IS NO LONGER REQUIRED AS BREW SHOULD AUTOMATICALLY INSTALL THE NECESSARY XCODE TOOLS
# THIS IS NOT NON-INTERACTIVE AS INSTALL XCODE THIS WAY REQUIRES MANUAL APPROVAL. TO DATE 2021/10 I HAVE NOT FOUND A 
# WAY IN WHICH TO SCRIPT SECURITY APPROVAL.

# ==============================================================================================================
# Xcode Install - non interactive
# This still requires interaction - have solved this by allowing brew to install xcode in the following step. 
# For details see:
# - https://www.freecodecamp.org/news/install-xcode-command-line-tools/
# ==============================================================================================================
# echo "Installing Xcode ... DO NOT TOUCH!!! Responses are scripted for you."

# xcode-select --install

# status=$?
# if [ $status -eq 1 ]; then
#     echo "General error"
# elif [ $status -eq 2 ]; then
#     echo "Misuse of shell builtins"
# elif [ $status -eq 126 ]; then
#     echo "Command invoked cannot execute"
# elif [ $status -eq 128 ]; then
#     echo "Invalid argument"
# fi

# # TODO this needs a try catch and currently cant figure out how
# # TODO this has a second ask we need to reutnr on
# sleep 1
# osascript <<EOD
#   tell application "System Events"
#     tell process "Install Command Line Developer Tools"
#       keystroke return
#       click button "Agree" of window "License Agreement"
#       tell menu bar 1
#         click button "Done"
#       end tell
#     end tell
#   end tell
# EOD

# echo "Xcode install complete"