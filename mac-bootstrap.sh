#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/
#
# Inspired by:
# - https://gist.github.com/codeinthehole/26b37efa67041e1307db
# - https://medium.com/@ivanaugustobd/your-terminal-can-be-much-much-more-productive-5256424658e8
# Get Time Stamp: Bash
# - https://newbedev.com/how-do-i-get-the-current-unix-time-in-milliseconds-in-bash
#
# - https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/AutomatetheUserInterface.html
# - https://www.macosxautomation.com/automator/folder-action/auto-approval-applet.html
# - https://macosxautomation.com/automator/security.html
# - https://scriptingosx.com/2020/09/avoiding-applescript-security-and-privacy-requests/
# - https://apple.stackexchange.com/questions/103621/run-applescript-from-bash-script
# - https://techviewleo.com/install-xcode-command-line-tools-macos/
# - https://www.freecodecamp.org/news/jazz-up-your-zsh-terminal-in-seven-steps-a-visual-guide-e81a8fd59a38/
# - https://oshyshkov.com/2020/12/20/my-shell-configuration-for-macos/ (terminal color config) **
# - https://www.thorsten-hans.com/5-types-of-zsh-aliases (zsh aliases)
# - https://github.com/matthieusb/zsh-sdkman
# - https://github.com/mosen/mysides
# - https://www.xmodulo.com/catch-handle-errors-bash.html
# - https://newbedev.com/is-there-a-try-catch-command-in-bash
# - https://medium.com/@Dylan.Wang/install-colorls-on-macos-mojave-10-14-6-970834959cdb - install colorls

# ==============================================================================================================
# Configure host file after install use
# - https://winhelp2002.mvps.org/hosts.txt
# ==============================================================================================================


# ==============================================================================================================
# Simple error handler
# ==============================================================================================================
simpleError() {
    echo "$val: Failed to install ...\n"
}

export START_TIME=$(($(date +%s)))
echo "Starting bootstrapping at $START_TIME"
# ==============================================================================================================
# Handle Script Options
# ==============================================================================================================
while getopts af:bi:bs:cs:cz:cu:ds:gs:is:it:ls:mc:zp:pa:pu:py:rg:si:tu:vc:vp:di: flag
do
    case "${flag}" in
        af) additionalFonts=${OPTARG};;
        bi) brewInstall=${OPTARG};;
        bs) browsersSupport=${OPTARG};;
        cs) cloudSupport=${OPTARG};;
        cz) configureZshAndBash=${OPTARG};;
        cu) coreUtilitiesUpdate=${OPTARG};;
        ds) developerSupport=${OPTARG};;
        gs) gameSupport=${OPTARG};;
        is) installSDKMAN=${OPTARG};;
        it) iTermColorSchemes=${OPTARG};;
        ls) languageSupport=${OPTARG};;
        mc) macOsConfig=${OPTARG};;
        zp) ohMyZshPlugins=${OPTARG};;
        pa) personalApps=${OPTARG};;
        pu) personalUtils=${OPTARG};;
        py) pythonPackages=${OPTARG};;
        rg) rubyGems=${OPTARG};;
        si) sdkPackageInstalls=${OPTARG};;
        tu) terminalUtilities=${OPTARG};;
        vc) vcsSupport=${OPTARG};;
        vp) vpnSupport=${OPTARG};;
        di) devInstall=${OPTARG};;
    esac
done

if [ -z "$additionalFonts" ];       then additionalFonts="TRUE"; fi
if [ -z "$brewInstall" ];           then brewInstall="TRUE"; fi
if [ -z "$browsersSupport" ];       then browsersSupport="TRUE"; fi
if [ -z "$cloudSupport" ];          then cloudSupport="TRUE"; fi
if [ -z "$configureZshAndBash" ];   then configureZshAndBash="TRUE"; fi
if [ -z "$coreUtilitiesUpdate" ];   then coreUtilitiesUpdate="TRUE"; fi
if [ -z "$developerSupport" ];      then developerSupport="TRUE"; fi
if [ -z "$gameSupport" ];           then gameSupport="TRUE"; fi
if [ -z "$installSDKMAN" ];         then installSDKMAN="TRUE"; fi
if [ -z "$iTermColorSchemes" ];     then iTermColorSchemes="TRUE"; fi
if [ -z "$languageSupport" ];       then languageSupport="TRUE"; fi
if [ -z "$macOsConfig" ];           then macOsConfig="TRUE"; fi
if [ -z "$ohMyZshPlugins" ];        then ohMyZshPlugins="TRUE"; fi
if [ -z "$personalApps" ];          then personalApps="TRUE"; fi
if [ -z "$personalUtils" ];         then personalUtils="TRUE"; fi
if [ -z "$pythonPackages" ];        then pythonPackages="TRUE"; fi
if [ -z "$rubyGems" ];              then rubyGems="TRUE"; fi
if [ -z "$sdkPackageInstalls" ];    then sdkPackageInstalls="TRUE"; fi
if [ -z "$terminalUtilities" ];     then terminalUtilities="TRUE"; fi
if [ -z "$vcsSupport" ];            then vcsSupport="TRUE"; fi
if [ -z "$vpnSupport" ];            then vpnSupport="TRUE"; fi
if [ -z "$devInstall" ];            then devInstall="TRUE"; fi

if [ $devInstall == FALSE ]; then
    echo "Ignoring all dev installs ..."
    cloudSupport="FALSE"
    developerSupport="FALSE"
    installSDKMAN="FALSE"
    sdkPackageInstalls="FALSE"
    languageSupport="FALSE"
    pythonPackages="FALSE"
    rubyGems="FALSE"
fi

echo "Include additional fonts: $additionalFonts";
echo "Include brew: $brewInstall";
echo "Include additional browsers: $browsersSupport";
echo "Include AWS and GCP support: $cloudSupport";
echo "Configure ZSH and BASH: $configureZshAndBash";
echo "Include core utilities updates: $coreUtilitiesUpdate";
echo "Include developer tools: $developerSupport";
echo "Include game support: $gameSupport";
echo "Include SDKMAN: $installSDKMAN";
echo "Include iTerm color schemes: $iTermColorSchemes";
echo "Include language support: $languageSupport";
echo "Configure macOS: $macOsConfig";
echo "Include ZSH plugins: $ohMyZshPlugins";
echo "Include personal apps: $personalApps";
echo "Include personal utilities: $personalUtils";
echo "Include python packages: $pythonPackages";
echo "Include ruby gems: $rubyGems";
echo "Include Java / Maven / Gradle: $sdkPackageInstalls";
echo "Include terminal utilities: $terminalUtilities";
echo "Include VCS support: $vcsSupport";
echo "Include VPN support: $vpnSupport";
echo "Include all dev installs: $devInstall";

# ==============================================================================================================
# Homebrew: Check for existing install, install if not present
# ==============================================================================================================
source brewInstall.sh

# ==============================================================================================================
# Updates: Update outdated utilities
# ==============================================================================================================

if [ $coreUtilitiesUpdate == TRUE ]; then
    source coreUtilitiesUpdate.sh
else
    echo "Excluding core utility updates ..."
fi

# ==============================================================================================================
# Unix / Linux command line utilities to install
# ==============================================================================================================

if [ $terminalUtilities == TRUE ]; then
    source terminalUtilities.sh
else
    echo "Excluding terminal utility packages ..."
fi

# ==============================================================================================================
# Scripting language support for local environment
# ==============================================================================================================

if [ $languageSupport == TRUE ]; then
    source languageSupport.sh
else
    echo "Excluding language support packages ..."
fi

# ==============================================================================================================
# Vcs support: Git, Mercurial, SVN
# ==============================================================================================================

if [ $vcsSupport == TRUE ]; then
    source vcsSupport.sh
else
    echo "Excluding language support packages ..."
fi

# ==============================================================================================================
# Support for AWS and GCP
# ==============================================================================================================

if [ $cloudSupport == TRUE ]; then
    source cloudSupport.sh
else
    echo "Excluding language support packages ..."
fi

# ==============================================================================================================
# Clean up brew installs
# ==============================================================================================================

echo "Cleaning up brew installs ..."

brew cleanup

echo "Brew installs cleaned"

# ==============================================================================================================
# Personal Utilities
# ==============================================================================================================

if [ $personalUtils == TRUE ]; then
    source personalUtilities.sh
else
    echo "Excluding personal utilities ..."
fi

# ==============================================================================================================
# General / Personal applications we want installed
# ==============================================================================================================

if [ $personalApps == TRUE ]; then
    source personalApps.sh
else
    echo "Excluding personal apps ..."
fi

# ==============================================================================================================
# Install additional browsers
# ==============================================================================================================

if [ $browsersSupport == TRUE ]; then
    source browserSupport.sh
else
    echo "Excluding third party browsers ..."
fi
# ==============================================================================================================
# Install VPNs
# ==============================================================================================================

if [ $vpnSupport == TRUE ]; then
    source vpnSupport.sh
else
    echo "Excluding vpn support ..."
fi

# ==============================================================================================================
# Install Developer Tools
# ==============================================================================================================

if [ $developerSupport == TRUE ]; then
    source developerSupport.sh
else
    echo "Excluding language support packages..."
fi

# ==============================================================================================================
# Install Games and Game Stores
# ==============================================================================================================

if [ $gameSupport == TRUE ]; then
    source gameSupport.sh
else
    echo "Excluding language support packages..."
fi

# ==============================================================================================================
# Install Additional Fonts
# ==============================================================================================================

if [ $additionalFonts == TRUE ]; then
    source additionalFonts.sh
else
    echo "Excluding additional fonts..."
fi

# ==============================================================================================================
# Install Python
# ==============================================================================================================

if [ $pythonPackages == TRUE ]; then
    source pythonPackages.sh
else
    echo "Excluding python packages..."
fi

# ==============================================================================================================
# Install Ruby Gems
# ==============================================================================================================

if [ $rubyGems == TRUE ]; then
    source rubyGems.sh
else
    echo "Excluding ruby gems ..."
fi

# ==============================================================================================================
# Install Npm
# ==============================================================================================================
echo "Installing global npm packages ..."

npm install marked -g

echo "NPM Installed"

# ==============================================================================================================
# Configure macOS
# ==============================================================================================================

if [ $macOsConfig == TRUE ]; then
    source macOsConfig.sh
else
    echo "Excluding macOS config ..."
fi

# ==============================================================================================================
# Create Additional Directories
# ==============================================================================================================
echo "Creating additional folder structure ..."

echo "Start from home: $HOME"

# Make sure we are in the home directory
cd ${HOME}

[[ ! -d Repository ]] && mkdir Repository
[[ ! -d Tools ]] && mkdir Tools
[[ ! -d Data ]] && mkdir Data

echo "Adding folders to Finder side bar ..."

mysides add example file:///$HOME/Repository
mysides add example file:///$HOME/Tools
mysides add example file:///$HOME/Data

# ==============================================================================================================
# Install OH MY ZSH
# - https://github.com/ohmyzsh/ohmyzsh#unattended-install
# ==============================================================================================================

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ==============================================================================================================
# Install OH MY ZSH Plugins
# ==============================================================================================================

if [ $ohMyZshPlugins == TRUE ]; then
    source ohMyZshPlugins.sh
else
    echo "Excluding ZSH plugins and themes ..."
fi

# ==============================================================================================================
# Configure Bash Profile (Just in case) and zshrc
# ==============================================================================================================

if [ $configureZshAndBash == TRUE ]; then
    source configureZshAndBash.sh
else
    echo "Excluding ZSH and Bash configs ..."
fi

# ==============================================================================================================
# Configure iTerm color profiles
# ==============================================================================================================

if [ $iTermColorSchemes == TRUE ]; then
    source iTermColorSchemes.sh
else
    echo "Excluding iTerm color schemes ..."
fi

# ==============================================================================================================
# Install SDKMAN!
# ==============================================================================================================

if [ $installSDKMAN == TRUE ]; then
    source installSDKMAN.sh
else
    echo "Excluding SDKMAN install ..."
fi

# ==============================================================================================================
# Install SDKMAN!
# ==============================================================================================================

if [ $sdkPackageInstalls == TRUE ]; then
    source sdkPackageInstalls.sh
else
    echo "Excluding Java / Maven / Gradle installs  ..."
fi

echo "Bootstrapping complete, final step ..."

export END_TIME=$(($(date +%s)))

echo "Total time taken to install (in seconds): ($END_TIME - $START_TIME)"











