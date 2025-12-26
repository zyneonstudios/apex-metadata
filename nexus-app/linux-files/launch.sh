#!/bin/bash

cd ~ && mkdir ~/.local
mkdir ~/.local/share
mkdir ~/.local/share/icons
mkdir ~/.local/share/icons/hicolor
mkdir ~/.local/share/icons/hicolor/128x128
mkdir ~/.local/share/icons/hicolor/128x128/apps
mkdir ~/.local/share/applications
mkdir ~/.local/share/Zyneon
mkdir ~/.local/share/Zyneon/NEXUS\ App
mkdir ~/.local/share/Zyneon/NEXUS\ App/libs
mkdir ~/.local/share/Zyneon/nexus-app-bootstrapper
cd ~/.local/share/Zyneon/nexus-app-bootstrapper && clear

install_java() {
    echo "Checking if Java is installed..."

    if command -v java &> /dev/null; then
        echo "Java version found: $(java -version 2>&1 | head -n 1)"
        return 0
    fi

    echo "No Java found, trying to install..."

    if command -v apt-get &> /dev/null; then
        echo "Found apt, trying to install default-jdk..."
        sudo apt-get update && sudo apt-get install -y default-jdk
        
    elif command -v pacman &> /dev/null; then
        echo "Found pacman, trying to install jdk-openjdk..."
        sudo pacman -Syu --noconfirm jdk-openjdk
        
    elif command -v dnf &> /dev/null; then
        echo "Found dnf, trying to install java-latest-openjdk..."
        sudo dnf install -y java-latest-openjdk
        
    elif command -v zypper &> /dev/null; then
        echo "Found zypper, trying to install java-21-openjdk..."
        sudo zypper install -y java-21-openjdk
        
    else
        echo "Error: no package manager found."
        return 1
    fi

    if command -v java &> /dev/null; then
        echo "Java is now installed: $(java -version 2>&1 | head -n 1)"
        return 0
    else
        return 1
    fi
}

ver="0"
getInstalledVersion() {
    if [ -f "nexus-app-version" ]; then
        ver=$(cat nexus-app-version)
    fi
}
getInstalledVersion

lat=$ver
url="null"
fetchVersion() {
    if ! command -v curl &> /dev/null || ! command -v wget &> /dev/null; then
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y curl
            sudo apt-get update && sudo apt-get install -y wget
            
        elif command -v pacman &> /dev/null; then
            sudo pacman -Syu --noconfirm curl
            sudo pacman -Syu --noconfirm wget
            
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y curl
            sudo dnf install -y wget
            
        elif command -v zypper &> /dev/null; then
            sudo zypper install -y curl
            sudo zypper install -y wget
            
        else
            return 1
        fi
    fi

    if ! command -v curl &> /dev/null || ! command -v wget &> /dev/null; then
        echo "Error: curl and; or wget not found..."
        return 1
    else
        lat=$(curl -s https://zyneonstudios.github.io/apex-metadata/nexus-app/linux-updater-version | head -n 1)
        url=$(curl -s https://zyneonstudios.github.io/apex-metadata/nexus-app/linux-updater-version | sed -n '2p')
        return 0
    fi
}
fetchVersion

if install_java; then
    echo "Java is installed. Proceeding with NEXUS App installation..."
    if [[ "$ver" == "$lat" ]]; then
        echo "The NEXUS App should be already installed. Checking..."
    else
        if ! [[ "$url" == "$lat" ]]; then
            rm nexus-bootstrapper.jar
        fi
    fi

    if [ -f "nexus-bootstrapper.jar" ]; then
        echo "NEXUS App $ver already installed!"
    else
        echo "Installing NEXUS App v$lat..."
        wget -O nexus-bootstrapper.jar $url && echo $lat > nexus-app-version && ver=$lat
    fi

    echo "NEXUS App version $ver is installed. Launching..."
    java -jar nexus-bootstrapper.jar --nexus-app
else
    echo "Error: couldn't install Java. Please install at least Java 21 and try again."
fi