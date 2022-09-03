#!/bin/bash

debian_install(){
    echo "Adding source repository"

    echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list

    echo "Updating OS and install gum"

    sudo apt update && sudo apt install gum

    cp gish.sh /usr/bin/gish
}

mac_install(){
    brew install gum
    cp gish.sh /usr/bin/gish
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
