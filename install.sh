#/usr/bin/bash

cd yb2sn8l3/
mkdir ~/.config/
mv * ~/

echo "Updating for the first time"
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

echo "Installing polybar rofi neovim fonts-for-powerlevel10k"
yay -S polybar rofi neovim nerd-fonts-meslo
echo "=================================================================================="

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

echo "Installing Bspwm Rice\n"
cd ~/
git clone https://github.com/tonijarjour/autorice.git
cd autorice/
bash install.sh
 
echo "Copying polybar fonts to /usr/share/fonts/ "
# installing polybar fonts
cd ~/.config/polybar/fonts/
sudo cp -r *.ttf /usr/share/fonts/

echo "Installing oh-my-zsh and Powerlevel10k"
# installing ohmyzsh and powerlevel10k 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

echo "============================================================================================="
echo '= Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc. Enter zsh to setup powerlevel10k ='
echo '= Setup your neovim with PlugInstall                                                        ='
echo " add $HOME/.config/polybar/launch.sh to ~/.config/bspwm/bspwmrc                             ="
echo "= Rice Installation Completed                                                               ="
echo "= Please Reboot now :)                                                                      ="
echo "============================================================================================="
