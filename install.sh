#/usr/bin/bash

echo "Updating for the first time"
echo "==============================================================================="
# first update
sudo pacman -Syu
echo "Update completed"
echo "================================================================================"

echo "Installing Essential-softwares (git and dkms)"
# install essentials
sudo pacman -Syu git dkms firefox zsh
echo "Installation Completed"
echo "================================================================================="

# install yay
echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/
echo "yay installed"
echo "=================================================================================="

echo "Installing nvim"
yay -S neovim nerd-fonts-meslo

echo "Installing oh-my-zsh and Powerlevel10k" 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Installing wifi-driver rtl8723de"
# install wifi-driver 
git clone -b extended --single-branch https://github.com/lwfinger/rtlwifi_new.git
cd rtlwifi_new
sudo dkms add ../rtlwifi_new
sudo dkms build rtlwifi-new/0.6
sudo dkms install rtlwifi-new/0.6
sudo modprobe -v rtl8723de ant_sel=2
sudo /bin/sh -c 'echo "options rtl8723de ant_sel=2" >> /etc/modprobe.d/rtl8723de.conf'
echo "Wifi-driver Installed"
echo "===================================================================================="

echo "Installing Bspwm Rice\n Uncomment your personal repository git clone at https://github.com/thisisshub/.config.git if needed"
# change directory to the .config folder
mkdir ~/.config
cd ~/.config
# git clone contents of .config repository
git clone https://github.com/tonijarjour/autorice.git
cd autorice/
bash install.sh
echo "Installing neovimrc"
cd ~/.config
git clone https://github.com/thisisshub/.config.git
cd ~/.config
mv * ../
cd ../
rm -rf .config/

echo "Installing oh-my-zsh and Powerlevel10k"
# installing ohmyzsh and powerlevel10k 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

echo "===========================================================================================\n"
echo '= Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc. Enter zsh to setup powerlevel10k =\n'
echo '= Setup your neovim with PlugInstall                                                        =\n'
echo "= Rice Installation Completed                                                               =\n"
echo "= Please Reboot now :)                                                                      =\n"
echo "=============================================================================================\n"

