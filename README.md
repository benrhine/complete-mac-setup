# complete-mac-setup
Opinionated bash scripts to fully setup a mac from start to finish with one command.

The primary intent of this script is to be a one stop shop to setup a new mac from scratch by running a single script. While the script is designed to be idempotent, I'm not a 100% sure thats true - at a minimum it is true for most cases. If part of the script fails you should be able to run it again and it should pick up where it left off. If you are running the script again you may see warnings that some items have already been installed.

Getting this script to run correctly without failures is the results of multiple weekends and many evenings. At this point I'm not certain the time savings of creating the script justifies the time put into creating it but I sincearly hope that many of you can put it to good use.

### A word on the She-bang (Important!!!)
While this might seem a bit odd to call out as something so important it took alot of work to really understand this and what it really means in terms of running the script. The script that inspired this used the `#!/usr/bin/env bash` she-bang which is fine but it is different than the standard `#!/user/bin`. [This](https://unix.stackexchange.com/questions/206350/what-is-the-difference-if-i-start-bash-with-bin-bash-or-usr-bin-env-bash) does a good job of explaining some of the differences of how this behaves or changes behavior. I would have left this alone as in reading the above and the links below asnit appears the `#!/usr/bin/env bash` declaration is good for portability but I was really hoping to not have to manually grant full disk access to terminal prior to running the script. Below are my she-bang testing results ...
- `#!/user/bin` does not seem to actually run on macOS Catalina anymore
- `#!/usr/bin/env bash` everything is fine with this declaration but must add terminal to the full disk access group. See the Preparing to run the Script section.
- `#!/bin/sh` due to permissions automatically applied by the os do not require the user to manually add full disk access to terminal before running the scripts.
- `#!/bin/zsh`I did not consider switching to zsh as it caused additional issues described [here](https://scriptingosx.com/2019/08/moving-to-zsh-part-8-scripting-zsh/).

- https://developer.apple.com/forums/thread/672023

### Other links
- https://medium.com/@Dylan.Wang/install-colorls-on-macos-mojave-10-14-6-970834959cdb

### Preparing to run the Script (depricated)

Note: This step is no longer necessary after switching the script she-bang to `#!/bin/sh`

Assuming this is a fresh macOS install start by opening `System Preferences -> Security & Privacy -> Select: Full Disk Access -> Click the lock and enter your password -> Click the + -> Add Terminal`. Once you have granted full disk access to terminal close System Preferences and then copy the `complete-mac-set` script folder to your machine. Open Terminal.

### Running the Script

If terminal asks you for permissions at any point tell it ok. I dont believe that it should ask unless you are trying to use auto complete.

With terminal open `cd` into `YOUR-LOCATION/complete-mac-set`, the script assumes you dropped the folder on the desktop. If you placed it somehwere other than the desktop you will need to edit the `mac-bootstrap.sh` and update the `SCRIPT_DIR` to your location. Once in the scripts directory run `./mac-bootstrap.sh`. When the script starts it will ask you for your password (which you will have to enter a total of 4? times during the script run) followed by asking you to press enter to allow brew to install the xcode dependencies necessary to run the script. After that the script will prompt you to answer your password twice more before completing. The script has basic error handling and in most cases if something fails it should output a message then continue on.

#### Recommendation
I recommend piping the script output to a log file just in the event anything goes wrong it will be somewhat easier to debug. Instead of from your directory running `./mac-bootstrap.sh` run instead `./mac-bootstrap.sh | tee -a $HOME/Desktop/complete-mac-setup/install-log`

### Post Script Manual Configuration

In order for everything to appear correctly once the script completes, in terminal, `Preferences -> Profiles -> Text -> Font | Change -> Select Hack`. Once this is done everything in terminal should display correctly.

## Things I would like to add
- automatic Git configuration
- auto install of browser plugins
	- There are a few stack overflow articles about this but they are all significantly dated and not very clear on if there is a actual way to do this.

### Install Options

By default the script will install everything that is configured. The primary intent of this script is to set up a new machine all in go, but I have included a number of flags to disable the instalation of certain components. The flags are as follows ...

```shell
The default value for all of the following is TRUE. In order NOT install any set pass in FALSE.

af) Install addtional fonts
	- TRUE | FALSE
bi) Install Brew
	- TRUE | FALSE
bs) Install additional browsers
	- TRUE | FALSE
cs) Install support for AWS and GCP
	- TRUE | FALSE
cz) Configure ZSH and Bash
	- TRUE | FALSE
cu) Update old versions of core utilities on macOS
	- TRUE | FALSE
ds) Install developer tools
	- TRUE | FALSE
gs) Install games and game stores
	- TRUE | FALSE
is) Install SDKMAN!
	- TRUE | FALSE
it) Install additional color styles for iTerm
	- TRUE | FALSE
ls) Install scripting languages
	- TRUE | FALSE
mc) Configure macOS settings
	- TRUE | FALSE
zp) Install additional ZSH plugins
	- TRUE | FALSE
pa) Install personal applications
	- TRUE | FALSE
pu) Install personal utilities
	- TRUE | FALSE
py) Install python packages
	- TRUE | FALSE
rg) Install ruby gems
	- TRUE | FALSE
si) Install sdk man packages (Java / Maven / Gradle)
	- TRUE | FALSE
tu) Install terminal utilities
	- TRUE | FALSE
vc) Install VCS support
	- TRUE | FALSE
vp) Install VPM support
	- TRUE | FALSE
di) Configure multiple dev installs at once
	- TRUE | FALSE

```

#### Runtime

The script normally takes approximately 1 hour to run.

#### Total install size

This script installs approximately 30 gigs worth of stuff (I think 10g of that is xcode for some reason). My starting vm for testing is 24g and my ending size is approximately 54g.

## What is installed?

### af)
Install additional fonts. Note `font-hack-nerd-font` is the only real requirement as it is needed for icons to be displayed in the shell once the process is completed.
```shell
font-hack-nerd-font
font-inconsolata
font-roboto
font-clear-sans
font-anonymous-pro
font-dejavu-sans-mono-for-powerline
font-droid-sans-mono-for-powerline
font-meslo-lg
font-input
font-inconsolata
font-inconsolata-for-powerline
font-liberation-mono-for-powerline
font-meslo-lg
font-nixie-one
font-office-code-pro
font-pt-mono
font-raleway
font-source-code-pro
font-source-code-pro-for-powerline
font-source-sans-pro
font-ubuntu 
font-ubuntu-mono-powerline
font-covered-by-your-grace
font-hack
font-league-gothic
font-rambla
font-share-tech

```
### bi)
This switch actually currently does nothing. The whole script depends on brew so there is currently no way to disable it.
```shell
Installs Homebrew 
```
### bs)
```shell
brave-browser
- Privacy focused browser
- https://brave.com
firefox
- https://www.mozilla.org/en-US/firefox/
google-chrome
- https://www.google.com/chrome/
```
### cs)
```shell
awscli
- https://aws.amazon.com/cli/
aws-console
- https://aws.amazon.com/console/
google-cloud-sdk
-https://cloud.google.com/sdk
```
### cz)
```shell
Installs custom ZSH and Bash profiles
- https://github.com/benrhine/bashConfigWithGit
- https://github.com/benrhine/zshenvWithGit
```
### cu)
```shell
bash
- Update to Bash 4
coreutils
findutils
gnu-sed
gnu-tar
gnu-indent
gnu-which
grep
```
### ds)
```shell
docker
- https://www.docker.com
intellij-idea-ce
intellij-idea
- https://www.jetbrains.com/idea/download/#section=mac
iterm2
- https://iterm2.com
macvim
- https://github.com/macvim-dev/macvim
postman
- https://www.postman.com
slack
- https://slack.com
vagrant
- https://www.vagrantup.com
```
### gs)
```shell
epic-games
- https://www.epicgames.com/store/en-US/
gog-galaxy
- https://www.gog.com
minecraft
- https://www.minecraft.net/en-us/store/minecraft-java-edition
moonlight
- https://moonlight-stream.org
openemu
- https://openemu.org
parsec
- https://parsec.app
steam
- https://store.steampowered.com
retroarch-metal
- https://www.retroarch.com
```
### is)
```shell
Install SDKMAN!!!
- https://sdkman.io
```
### it)
```shell
Install iTerm color schemes
```
### ls)
```shell
go
markdown
node
npm
postgresql
python
python3
pypy
rabbitmq
ruby
yarn
```
### mc)
```shell
macOS Configuration
- Shows hidden files by default
- Shows ~/Library by default
- Sets accent color to graphite - ie no more brightly collored window bubbles
- Display full path in finder window
- Display breadcrumps in finder window
- Set finder to list view by default
- Set right click
- Show file extensions by default
- Configure screensaver password
- Configure screenshot locations
- Set menu to auto hide
- Set dock to auto hide
- Set dock magnification
```
### zp)
```shell
zsh-syntax-highlighting
- https://github.com/zsh-users/zsh-syntax-highlighting
zsh-autosuggestions
- https://github.com/zsh-users/zsh-autosuggestions
zsh-sdkman
- https://github.com/matthieusb/zsh-sdkman
powerlevel9k
- https://github.com/Powerlevel9k/powerlevel9k
powerlevel10k
- https://github.com/romkatv/powerlevel10k
- https://github.com/romkatv/powerlevel10k#installation
```
### pa)
```shell
evernote
- https://evernote.com
google-drive
- https://www.google.com/drive/download/
mixed-in-key
- https://mixedinkey.com/splash/
obs
- https://obsproject.com
parallels
- https://www.parallels.com
rambox
- https://rambox.app/#home
transmit
- https://panic.com/transmit/
twitch
- https://www.twitch.tv/downloads
```
### pu)
```shell
blackhole-16ch
- https://github.com/ExistentialAudio/BlackHole
- Since macs do not have dedicated soundcars this allows for the creation of a virtual audio device and custom audio routing. Note: This will be necessary if you want to stream audio using obs or some other streaming tool.
gas-mask
- https://github.com/2ndalpha/gasmask
- Allows for easy host file editing
- This script sets a hostfile by default so this is probably unnecessary but its hear for easy access
geektool
- https://www.tynsoe.org/geektool/
- mac themeing tool, its a bit older now prefer ubersicht
gpg-suite
- https://gpgtools.org
monolingual
- https://ingmarstein.github.io/Monolingual/
mysides
- https://github.com/mosen/mysides
sublime-text
- https://www.sublimetext.com
ubersicht
- https://tracesof.net/uebersicht/
vlc
- https://www.videolan.org
```
### py)
This was inherited from the script that inspired this work. Honestly not sure what this does.
```shell
ipython
virtualenv
virtualenvwrapper
```
### si)
This was inherited from the script that inspired this work. Honestly not sure what this does.
```shell
bundler
filewatcher
```
### tu)
Additional shell commands that are nice to have on occasion that are not installed by default. Particularly `tree` is like a super version of `ls` if your looking for something specific. See example below. Additionall wget is super useful when trying to download files through terminal.
```shell
complete-mac-setup git:(main) ✗ tree
.
├── LICENSE
├── README.md
├── additionalFonts.sh
├── brewInstall.sh
├── browserSupport.sh
├── cloudSupport.sh
├── configureHosts.sh
├── configureZshAndBash.sh
├── coreUtilitiesUpdate.sh
├── developerSupport.sh
├── gameSupport.sh
├── iTermColorSchemes.sh
├── installSDKMAN.sh
├── languageSupport.sh
├── mac-bootstrap.sh
├── macOsConfig.sh
├── ohMyZshPlugins.sh
├── personalApps.sh
├── personalUtilities.sh
├── pythonPackages.sh
├── rubyGems.sh
├── sdkPackageInstalls.sh
├── terminalUtilities.sh
├── vcsSupport.sh
├── vpnSupport.sh
└── xcodeInstall.sh
```
What is installed
```shell
ag
ack
autoconf
automake
fd
ffind
ffmpeg
fpp
gettext
gifsicle
graphviz
hub
imagemagick
jq
libjpeg
libmemcached
pkg-config
rename
terminal-notifier
the_silver_searcher
tmux
tree
vim
watchman
wget
z
```
### vc)
Install git bc as a dev this is most likely what you will be using for version control. Also git and subversion are required for this script to complete without error. You could exclude mercurial if you want.
```shell
git
mercurial
subversion
```
### vp)
Install nordvpn if its something you use. If you need to create a custom vpn between your personal devices for access include zerotier-one. ZT allows you to easily add devices to your personal network and access them. ZT is fairly slow but I can say that while traveling extensively it allows me to access my home NAS just as if I were on my local network.
```shell
nordvpn
zerotier-one
```
### di)
Sets the following application groups to install or not. This is intended to allow the inclusion or exclusion of all development tools if you want to use this script but are not a developer.
```shell
cloudSupport="FALSE"
developerSupport="FALSE"
installSDKMAN="FALSE"
sdkPackageInstalls="FALSE"
languageSupport="FALSE"
pythonPackages="FALSE"
rubyGems="FALSE"
```
