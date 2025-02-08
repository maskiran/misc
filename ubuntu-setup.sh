sudo apt -y update
sudo apt -y upgrade
sudo apt -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -o $HOME/.zshrc https://raw.githubusercontent.com/maskiran/setup-mac/refs/heads/main/zshrc
curl -o $HOME/.oh-my-zsh/custom/themes/kiran.zsh-theme https://raw.githubusercontent.com/maskiran/setup-mac/refs/heads/main/kiran.zsh-theme
chsh -s /usr/bin/zsh
sudo reboot
