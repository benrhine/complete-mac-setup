# complete-mac-setup
Opinionated bash scripts to fully setup a mac from start to finish with one command.

The primary intent of this script is to be a one stop shop to setup a new mac from scratch by running a single script. While the script is designed to be idempotent, I'm not a 100% sure thats true - at a minimum it is true for most cases. If part of the script fails you should be able to run it again and it should pick up where it left off. If you are running the script again you may see warnings that some items have already been installed.

### Preparing to run the Script

Assuming this is a fresh macOS install start by opening `System Preferences -> Security & Privacy -> Select: Full Disk Access -> Click the lock and enter your password -> Click the + -> Add Terminal`. Once you have granted full disk access to terminal close System Preferences and then copy the `complete-mac-set` script folder to your machine. Open Terminal.

### Running the Script

With terminal open `cd` into `YOUR-LOCATION/complete-mac-set`. Once in the scripts directory run `./mac-bootstrap.sh`. Since we have alredy granted terminal full disk access we should not be get any security warnings from macOS. (Note: This is something I hope to fix in the future. If anyone knows how to update the Security Preference Pane from terminal from bash please let me know or submit a PR.) When the script starts it will ask you for your password (which you will have to enter a total of 3 times during the script run) followed by asking you to press enter to allow brew to install the xcode dependencies necessary to run the script. After that the script will prompt you to answer your password twice more before completing. The script has basic error handling and in most cases if something fails it should output a message then continue on.

### Post Script Manual Configuration

In order for everything to appear correctly once the script completes, in terminal, `Preferences -> Profiles -> Text -> Font | Change -> Select Hack`. Once this is done everything in terminal should display correctly.

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

This script installs approximately 25 gigs worth of stuff (I think 10g of that is xcode for some reason). My starting vm for testing is 24g and my ending size is ?

## What is installed?

### af)
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
firefox
google-chrome
```
### cs)
```shell
awscli
aws-console
google-cloud-sdk
```
### cz)
```shell
Installs custom ZSH and Bash profiles
```
### cu)
```shell
bash
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
google-cloud-sdk
intellij-idea-ce
intellij-idea
iterm2
macvim
postman
slack
vagrant
```
### gs)
```shell
epic-games
gog-galaxy
minecraft
moonlight
openemu
parsec
steam
retroarch-metal
```
### is)
```shell
Install SDKMAN!!!
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
```
### zp)
```shell
zsh-syntax-highlighting
zsh-autosuggestions
zsh-sdkman
powerlevel9k
powerlevel10k
```
### pa)
```shell
evernote
google-drive
mixed-in-key
obs
parallels
rambox
sublime-text
transmit
twitch
```
### pu)
```shell
blackhole-16ch
gas-mask
geektool
gpg-suite
monolingual
mysides
sublime-text
ubersicht
vlc
```
### py)
```shell
ipython
virtualenv
virtualenvwrapper
```
### si)
```shell
bundler
filewatcher
```
### tu)
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
```shell
git
mercurial
subversion
```
### vp)
```shell
nordvpn
zerotier-one
```
### di)
Sets the following application groups to install or not
```shell
cloudSupport="FALSE"
developerSupport="FALSE"
installSDKMAN="FALSE"
sdkPackageInstalls="FALSE"
languageSupport="FALSE"
pythonPackages="FALSE"
rubyGems="FALSE"
```
