apps=(
1password
adobe-creative-cloud
amazon-chime
docker
firefox
google-chrome
iterm2
macvim
microsoft-teams
raycast
shottr
visual-studio-code
wireshark
zoom
)
for app in ${apps[@]}; do
    echo brew install --cask $app
done

formulae=(
awscli
azure-cli
bat
dog
golang
google-cloud-sdk
ipcalc
jq
node
terraform
the_silver_searcher
tldr
youtube-dl
)
for app in ${formulae[@]}; do
    echo brew install $app
done
