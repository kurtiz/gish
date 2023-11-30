#!/bin/bash

debian_install(){
    echo "Downloading dependencies..."

    curl -O -L https://github.com/charmbracelet/gum/releases/download/v0.12.0/gum_0.12.0_amd64.deb

    echo "Updating OS and install gum"

    sudo apt update && sudo dpkg -i gum_0.12.0_amd64.deb && sudo apt install --fix-broken

    chmod +x gish.sh

    sudo cp gish.sh /usr/bin/gish
}

mac_install(){
    brew install gum

    chmod +x gish.sh

    sudo cp gish.sh /usr/bin/gish
}

if which git; then
    if [[ $OSTYPE == "linux-gnu"* ]]; then
        distro=$(lsb_release -i)
        if [[ $distro == *"Ubuntu"* ]]; then
            debian_install
        elif [[ $distro == *"Kali"* ]]; then
            debian_install
        elif [[ $distro == *"Debian"* ]]; then
            debian_install
        fi
    elif [[ $OSTYPE == "darwin"* ]]; then
            mac_install
    else
        echo "Cannot install for your OS / Distribution"
    fi
else
    echo "Visit https://git-scm.com/download/linux to install git"
fi
