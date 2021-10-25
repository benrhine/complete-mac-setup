#!/bin/sh
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
#- https://stackoverflow.com/questions/54818827/install-colorls-on-macos-and-zsh
# - https://community.jamf.com/t5/jamf-pro/finder-settings-script/td-p/186534
# - https://scriptingosx.com/2019/08/moving-to-zsh-part-8-scripting-zsh/
# - https://stackoverflow.com/questions/1401482/yyyy-mm-dd-format-date-in-shell-script
# ==============================================================================================================
# Simple error handler
# ==============================================================================================================
simpleError() {
    echo "$val: Failed to install ...\n"
}

export START_TIME=$(($(date +%s)))
export NUMBER_OF_STEPS=26
export SCRIPT_DIR=$HOME/Desktop/complete-mac-setup

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
# 1) Homebrew: Check for existing install, install if not present
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/brewInstall.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 1 of $NUMBER_OF_STEPS: Brew Install"
echo "=========================================================================================================\n"

source step-01-brewInstall.sh

# ==============================================================================================================
# 2) Updates: Update outdated utilities
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/coreUtilitiesUpdate.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 2 of $NUMBER_OF_STEPS: Update core utilities"
echo "=========================================================================================================\n"

if [ $coreUtilitiesUpdate == TRUE ]; then
    source step-02-coreUtilitiesUpdate.sh
else
    echo "Excluding core utility updates ..."
fi

# ==============================================================================================================
# 3) Unix / Linux command line utilities to install
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/terminalUtilities.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 3 of $NUMBER_OF_STEPS: Terminal utilities"
echo "=========================================================================================================\n"

if [ $terminalUtilities == TRUE ]; then
    source step-03-terminalUtilities.sh
else
    echo "Excluding terminal utility packages ..."
fi

# ==============================================================================================================
# 4) Scripting language support for local environment
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/languageSupport.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 4 of $NUMBER_OF_STEPS: Language support"
echo "=========================================================================================================\n"

if [ $languageSupport == TRUE ]; then
    source step-04-languageSupport.sh
else
    echo "Excluding language support packages ..."
fi

# ==============================================================================================================
# 5) Vcs support: Git, Mercurial, SVN
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/vcsSupport.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 5 of $NUMBER_OF_STEPS: VCS support"
echo "=========================================================================================================\n"

if [ $vcsSupport == TRUE ]; then
    source step-05-vcsSupport.sh
else
    echo "Excluding language support packages ..."
fi

# ==============================================================================================================
# 6) Support for AWS and GCP
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/cloudSupport.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 6 of $NUMBER_OF_STEPS: Cloud support"
echo "=========================================================================================================\n"

if [ $cloudSupport == TRUE ]; then
    source step-06-cloudSupport.sh
else
    echo "Excluding language support packages ..."
fi

# ==============================================================================================================
# 7) Clean up brew installs
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 7 of $NUMBER_OF_STEPS: Cleaning up brew installs ..."
echo "=========================================================================================================\n"

brew cleanup

echo "Brew installs cleaned"

# ==============================================================================================================
# 8) Personal Utilities
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/personalUtilities.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 8 of $NUMBER_OF_STEPS: Personal utilities"
echo "=========================================================================================================\n"

if [ $personalUtils == TRUE ]; then
    source step-08-personalUtilities.sh
else
    echo "Excluding personal utilities ..."
fi

# ==============================================================================================================
# 9) General / Personal applications we want installed
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/personalApps.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 9 of $NUMBER_OF_STEPS: Personal apps"
echo "=========================================================================================================\n"

if [ $personalApps == TRUE ]; then
    source step-09-personalApps.sh
else
    echo "Excluding personal apps ..."
fi

# ==============================================================================================================
# 10) Install additional browsers
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/browserSupport.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 10 of $NUMBER_OF_STEPS: Browser support"
echo "=========================================================================================================\n"

if [ $browsersSupport == TRUE ]; then
    source step-10-browserSupport.sh
else
    echo "Excluding third party browsers ..."
fi
# ==============================================================================================================
# 11) Install VPNs
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/vpnSupport.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 11 of $NUMBER_OF_STEPS: VPN support"
echo "=========================================================================================================\n"

if [ $vpnSupport == TRUE ]; then
    source step-11-vpnSupport.sh
else
    echo "Excluding vpn support ..."
fi

# ==============================================================================================================
# 12) Install Developer Tools
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/developerSupport.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 12 of $NUMBER_OF_STEPS: Developer support"
echo "=========================================================================================================\n"

if [ $developerSupport == TRUE ]; then
    source step-12-developerSupport.sh
else
    echo "Excluding language support packages..."
fi

# ==============================================================================================================
# 13) Install Games and Game Stores
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/gameSupport.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 13 of $NUMBER_OF_STEPS: Game support"
echo "=========================================================================================================\n"

if [ $gameSupport == TRUE ]; then
    source step-13-gameSupport.sh
else
    echo "Excluding language support packages..."
fi

# ==============================================================================================================
# 14) Install Additional Fonts
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/additionalFonts.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 14 of $NUMBER_OF_STEPS: Additional fonts"
echo "=========================================================================================================\n"

if [ $additionalFonts == TRUE ]; then
    source step-14-additionalFonts.sh
else
    echo "Excluding additional fonts..."
fi

# ==============================================================================================================
# 15) Install Python
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/pythonPackages.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 15 of $NUMBER_OF_STEPS: Python Packages"
echo "=========================================================================================================\n"

if [ $pythonPackages == TRUE ]; then
    source step-15-pythonPackages.sh
else
    echo "Excluding python packages..."
fi

# ==============================================================================================================
# 16) Install Ruby Gems
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/rubyGems.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 16 of $NUMBER_OF_STEPS: Ruby gems"
echo "=========================================================================================================\n"

if [ $rubyGems == TRUE ]; then
    source step-16-rubyGems.sh
else
    echo "Excluding ruby gems ..."
fi

# ==============================================================================================================
# 17) Install Npm
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 17 of $NUMBER_OF_STEPS: Npm"
echo "=========================================================================================================\n"

echo "Installing global npm packages ..."

npm install marked -g

echo "NPM Installed"

# ==============================================================================================================
# 18) Configure macOS
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/macOsConfig.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 18 of $NUMBER_OF_STEPS: Configure macOS"
echo "=========================================================================================================\n"

if [ $macOsConfig == TRUE ]; then
    source step-18-macOsConfig.sh
else
    echo "Excluding macOS config ..."
fi

# ==============================================================================================================
# 19) Create Additional Directories
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 19 of $NUMBER_OF_STEPS: Configure additional directories"
echo "=========================================================================================================\n"

echo "Make sure were in the HOME directory ..."

cd $HOME
pwd

echo "Creating additional folder structure ..."

[[ ! -d Repository ]] && mkdir Repository
[[ ! -d Tools ]] && mkdir Tools
[[ ! -d Data ]] && mkdir Data

[ -d "$HOME/Repository" ] && echo "Directory $HOME/Repository exists." || echo "Error: Directory $HOME/Repository does not exists."
[ -d "$HOME/Tools" ] && echo "Directory $HOME/Tools exists." || echo "Error: Directory $HOME/Tools does not exists."
[ -d "$HOME/Data" ] && echo "Directory $HOME/Data exists." || echo "Error: Directory $HOME/Data does not exists."


echo "Adding folders to Finder side bar ..."

mysides add Repository file:///$HOME/Repository
mysides add Tools file:///$HOME/Tools
mysides add Data file:///$HOME/Data

# ==============================================================================================================
# 20) Install OH MY ZSH
# - https://github.com/ohmyzsh/ohmyzsh#unattended-install
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 20 of $NUMBER_OF_STEPS: Install Oh My ZSH"
echo "=========================================================================================================\n"

pwd
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ==============================================================================================================
# 21) Install OH MY ZSH Plugins
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/ohMyZshPlugins.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 21 of $NUMBER_OF_STEPS: Install Oh My ZSH Plugins"
echo "=========================================================================================================\n"

if [ $ohMyZshPlugins == TRUE ]; then
    # Make sure parent script can see child scripts otherwise they will fail to run
    cd $SCRIPT_DIR
    pwd

    source step-21-ohMyZshPlugins.sh
else
    echo "Excluding ZSH plugins and themes ..."
fi

# ==============================================================================================================
# 22) Configure Bash Profile (Just in case) and zshrc
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/configureZshAndBash.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 22 of $NUMBER_OF_STEPS: Configure ZSH and BASH"
echo "=========================================================================================================\n"

if [ $configureZshAndBash == TRUE ]; then
    # Make sure parent script can see child scripts otherwise they will fail to run
    cd $SCRIPT_DIR
    pwd

    source step-22-configureZshAndBash.sh
else
    echo "Excluding ZSH and Bash configs ..."
fi

# ==============================================================================================================
# 23) Configure iTerm color profiles
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/iTermColorSchemes.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 23 of $NUMBER_OF_STEPS: Install iTerm color schemes"
echo "=========================================================================================================\n"

if [ $iTermColorSchemes == TRUE ]; then
    # Make sure parent script can see child scripts otherwise they will fail to run
    cd $SCRIPT_DIR
    pwd

    source step-23-iTermColorSchemes.sh
else
    echo "Excluding iTerm color schemes ..."
fi

# ==============================================================================================================
# 24) Install SDKMAN!
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/installSDKMAN.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 24 of $NUMBER_OF_STEPS: Install SDKMAN"
echo "=========================================================================================================\n"

if [ $installSDKMAN == TRUE ]; then
    # Make sure parent script can see child scripts otherwise they will fail to run
    cd $SCRIPT_DIR
    pwd

    source step-24-installSDKMAN.sh
else
    echo "Excluding SDKMAN install ..."
fi

# ==============================================================================================================
# 25) Install SDKMAN!
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/sdkPackageInstalls.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 25 of $NUMBER_OF_STEPS: Installing Java / Maven / Gradle"
echo "=========================================================================================================\n"

if [ $sdkPackageInstalls == TRUE ]; then
    source step-25-sdkPackageInstalls.sh
else
    echo "Excluding Java / Maven / Gradle installs  ..."
fi

# ==============================================================================================================
# 26) Install host file
#
# Alternate source import:
# - source $HOME/YOUR-PATH/complete-mac-setup/configureHosts.sh
# ==============================================================================================================

echo "\n========================================================================================================="
echo "Executing step 26 of $NUMBER_OF_STEPS: Configuring hosts file"
echo "=========================================================================================================\n"

source step-26-configureHosts.sh

echo "Bootstrapping complete, final step ..."

export END_TIME=$(($(date +%s)))

echo "Total time taken to install (in seconds): ($END_TIME - $START_TIME)"











