apps=(
1password
adobe-creative-cloud
alfred
docker
firefox
google-chrome
iterm2
raycast
visual-studio-code
alt-tab
)
for app in ${apps[@]}; do
    echo brew install --cask $app
done

formulae=(
bat
node
jq
the_silver_searcher
)
for app in ${formulae[@]}; do
    echo brew install $app
done
