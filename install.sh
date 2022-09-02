echo "Adding source repository\n"

echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list

echo "\nUpdating OS and install gum\n"

sudo apt update && sudo apt install gum
