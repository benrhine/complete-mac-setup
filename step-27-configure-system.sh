#!/bin/sh
# ==============================================================================================================
# Configure additional system actions
# ==============================================================================================================

cd $ICLOUD_DRIVE

mkdir obsidian-vaults

cd obsidian-vaults

git clone git@github.com:benrhine/obsidian-vaults.git

cd $HOME

# Configure qmd

echo '' >> ~/.zshrc
echo '# fnm (Fast Node Manager)' >> ~/.zshrc
echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zshrc

eval "$(fnm env --use-on-cd --shell zsh)"
fnm install 22
fnm use 22
fnm default 22
node --version   # Should show v22.x.x

npm install -g @tobilu/qmd

qmd --version

eval "$(fnm env --use-on-cd --shell zsh)" && fnm use 22 && qmd --version

# CREATE THE EMAIL TO MARKDOWN FOR OBSIDIAN AUTOMATOR SCRIPT
# YOU CAN FIND DETAILS ON THIS IN MY OBSIDIAN VAULT Mail to Obsidian Setup Guide

# Create the workflow file
cat << EOF > Mail to Md.workflow
<?xml version="1.0" encoding="UTF-8"?>
<plugin type="com.apple.mail">
    <description>Mail to Md</description>
    <main>
        <!-- Define the workflow's main action -->
        <action class="NSAppleScriptAction" identifier="mail_to_md">
            <script>
                <![CDATA[
                    tell application "Mail"
                        set _msgs to selected messages of message viewer 0
                        if (_msgs is not equal to missing value) then
                            set _msg to first item of _msgs
                            set _msgSender to (sender of _msg)
                            set _msgReceived to ((date received of _msg) as «class isot» as string)
                            set _msgSubject to (subject of _msg)
                            set _msgBody to (content of _msg)
                            set _msgId to (message id of _msg)

                            set _pythonScript to quoted form of "/Users/xtheshadowgod/Library/Mobile Documents/com~apple~CloudDocs/obsidian-vaults/IdeaverseAI/System/scripts/mail-to-md.py"

                            return do shell script "/opt/homebrew/bin/python3 " & _pythonScript & " " & (quoted form of _msgSender) & " " & (quoted form of _msgSubject) & " " & (quoted form of _msgReceived) & " " & (quoted form of _msgId) & " " & (quoted form of _msgBody)

                        end if
                    end tell
                ]]>
            </script>
        </action>
    </main>
</plugin>
EOF

# Compile the workflow
plutil -convert binary1 Mail to Md.workflow -o Mail to Md.app

osascript -e 'tell application "Automator" to set workflowFolder to POSIX path "/Users/'$(whoami)''/Documents:Automator Workflows:"' \
  && osascript -e 'tell application "Automator" to make new workflow at end of workflows in folder workflowFolder with properties {name:\"Mail to Md\", contents:{}}' \
  && osascript -e 'tell application "Automator" to tell workflow \"Mail to Md\" to add action \"mail_to_md\" from file ("./" + "Mail to Md.app") as alias'





