sudo apt update -y
sudo apt upgrade -y
sudo apt install -y zsh
curl -o ohmyzsh.sh -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
bash ohmyzsh.sh --unattended
rm ohmyzsh.sh
curl -o $HOME/.zshrc -fsSL https://raw.githubusercontent.com/maskiran/setup-mac/refs/heads/main/zshrc
curl -o $HOME/.oh-my-zsh/custom/themes/kiran.zsh-theme -fsSL https://raw.githubusercontent.com/maskiran/setup-mac/refs/heads/main/kiran.zsh-theme
sudo chsh -s /usr/bin/zsh $USER
sudo reboot

