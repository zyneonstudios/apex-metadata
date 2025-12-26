#!/bin/bash
cd ~ && clear
echo "================================================================"
echo "> Installing NEXUS App..."
echo "================================================================"
echo "Creating directories (messy but compatible 1/2)..."
mkdir ~/.local
mkdir ~/.local/share
mkdir ~/.local/share/icons
mkdir ~/.local/share/icons/hicolor
mkdir ~/.local/share/icons/hicolor/128x128
mkdir ~/.local/share/icons/hicolor/128x128/apps
mkdir ~/.local/share/applications
mkdir ~/.local/share/Zyneon
mkdir ~/.local/share/Zyneon/NEXUS\ App
mkdir ~/.local/share/Zyneon/NEXUS\ App/libs
echo "================================================================"
echo " "

echo "================================================================"
echo "> Installing NEXUS App..."
echo "================================================================"
echo "Creating directories (messy but compatible 2/2)..."
rm -r ~/.local/share/Zyneon/nexus-app-bootstrapper
mkdir ~/.local/share/Zyneon/nexus-app-bootstrapper
echo "================================================================"
echo " "

cd ~/.local/share/Zyneon/nexus-app-bootstrapper && clear
echo "================================================================"
echo "> Installing NEXUS App..."
echo "================================================================"
echo "Downloading launch script..."
rm launch.sh
wget https://zyneonstudios.github.io/apex-metadata/nexus-app/linux-files/launch.sh
chmod a+x launch.sh
echo "================================================================"
echo " "

cd ~/.local/share/Zyneon/nexus-app-bootstrapper && clear
echo "================================================================"
echo "> Installing NEXUS App..."
echo "================================================================"
echo "Downloading icon..."
wget https://zyneonstudios.github.io/apex-metadata/nexus-app/linux-files/icon.png
rm ~/.local/share/icons/hicolor/128x128/apps/nexus-app.png
mv icon.png ~/.local/share/icons/hicolor/128x128/apps/nexus-app.png
echo "================================================================"
echo " "

cd ~/.local/share/Zyneon/nexus-app-bootstrapper && clear
echo "================================================================"
echo "> Installing NEXUS App..."
echo "================================================================"
echo "Downloading shortcut file..."
wget https://zyneonstudios.github.io/apex-metadata/nexus-app/linux-files/nexus-app.desktop
rm ~/.local/share/applications/nexus-app.desktop
mv nexus-app.desktop ~/.local/share/applications/nexus-app.desktop
chmod a+x ~/.local/share/applications/nexus-app.desktop
echo "================================================================"
echo " "

clear
echo "================================================================"
echo "> Intalling NEXUS App..."
echo "================================================================"
echo "The app is now installed. Have fun!"
echo "================================================================"
echo " "