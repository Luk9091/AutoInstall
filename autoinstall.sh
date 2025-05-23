#! /usr/bin/bash

source colors.sh
source packages.sh

# Configuration:
SHELL_CONFIG=true
activeNumlock=false
install_RUST=true
install_ISE=true
install_RIVAL=true
install_PICO_SDK=true

myPath=$(pwd)

echo -e "${ORANGE}Enter your email:${NC}"
read EMAIL

for del in $REMOVED; do
    sudo apt remove --purge $del -y
done

# Pre update
(sudo apt update && sudo apt upgrade -y) || exit


for repo in $REPOS; do
    check=$(sudo add-apt-repository --list | grep ${repo##*/} | wc -l)
    if [[ $check == 0 ]]; then
        sudo add-apt-repository $repo -y
    fi
done

sudo apt update
sudo apt upgrade -y


for package in $PACKAGES; do
    (sudo apt install $package -y && echo -e "${GREEN}Successful installed $package${NC}") || (( echo -e "${RED}Failed install $package${NC}" && echo -e ${package} >> errorInstall ))
done

IS_PYTHON=$(sudo apt list --installed | grep python3/ | wc -l)
if [ "$IS_PYTHON" == "1" ]; then
    echo "Install lib"
    for lib in $PYTHON_LIB; do
        (sudo apt install $lib -y && echo -e "${GREEN}Successful installed $lib${NC}") || echo -e "${RED}Failed install $lib${NC}"
    done
fi



#curl -fsS https://dl.brave.com/install.sh | sh Install brave:
if [ -d $(which brave-browser) ]; then
    curl -fsS https://dl.brave.com/install.sh | sh
fi


# To installing ISE:
if [ $install_ISE ]; then
    echo -e "${RED}ISE dependency install${NC}"
    sudo add-apt-repository universe
    sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
#    echo -e "${BLUE}Add this line to: ${YELLOW}/ect/apt/source.list${NC}"
#    echo -e "${YELLOW}deb http://ma.archive.ubuntu.com/ubuntu lunar main restricted universe multiverse${NC}"
#    read -p "Press ${RED}ANY${NC} to continue" -rsn1 key
    sudo apt update
    # sudo add-apt-repository universe -y
    sudo apt-get install libncurses5 -y
fi


sudo apt autoremove -y
sudo apt autoclean -y
sudo apt autopurge -y

# Install VS Code:
if [ -d $(which code) ]; then
    chmod u+x ./installCode.sh
    ./installCode.sh
else
    echo -e "${GREEN}Code been installed${NC}"
fi


# Install rust:
if [[ $install_RUST == true  &&  -n $(which rustc) ]]; then
    rustc --version || (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)
fi

# Add ssh to git
SSH_CHECK=$(ssh -T git@github.com 2>&1)
if [[ "$SSH_CHECK" != "Hi Luk9091! You've successfully authenticated, but GitHub does not provide shell access." ]]; then
    ssh-keygen -t rsa -b 4096 -C $EMAIL
    echo -e "\n##################################################\n"

        echo -e $(cat /home/lukasz/.ssh/id_rsa.pub)

    echo -e "\n##################################################\n"
    echo -e "Copy this ^ key to ssh settings in Github!"
    echo -e "When you paste it press [Enter]"
        
    read -p "Press ${RED}ANY${NC} to continue" -rsn1 key

# Git alias:
    git config --global alias.adog "log --all --decorate --oneline --graph"
    git config --global alias.alog 'log --graph  --format=format:"%C(yellow)%h%C(reset) %C(bold green)(%ar) %C(bold dim cyan)%an %C(reset)%s"'
    git config --global alias.cm   "commit -m"
    git config --global alias.cma  "commit --amend -m"
    git config --global alias.ca   "commit --amend --no-edit"

# Profile settings:
    git config --global user.email $EMAIL
    git config --global user.name "Łukasz Przystupa"
    git config --global init.defaultBranch main
fi


# Install raspberry pico SDK:
if [[ $install_PICO_SDK && ! -d /opt/pico ]]; then
    cd $myPath
    ./pico_sdk.sh
    # echo "alias PICOprobe='openocd -f interface/cmsis-dap.cfg -c \"adapter speed 5000\" -f target/rp2040.cfg -s tcl'" >> ~/.zshrc
fi

if [[ $install_RIVAL && ! -d ~/.config/rivalcfg ]] ; then
    cd ~/.config
    git clone git@github.com:flozz/rivalcfg.git
    cd rivalcfg
    sudo python3 setup.py install
    sudo rivalcfg --update-udev
    echo -e "${GREEN} Rival config is installed${NC}"
fi



# # Config ZSH:
if [ $SHELL_CONFIG ]; then
    mkdir ~/.config/zsh -p
    cd ~/.config/zsh
    if [ ! -d ./zsh-autocomplete ]; then git clone git@github.com:marlonrichert/zsh-autocomplete.git; fi
    if [ ! -d ./zsh-autosuggestions ]; then git clone git@github.com:zsh-users/zsh-autosuggestions.git; fi
    if [ ! -d ./zsh-syntax-highlighting ]; then git clone git@github.com:zsh-users/zsh-syntax-highlighting.git; fi
fi

# set ZSH as default shell and config SHELL
if [[ $SHELL_CONFIG &&  ! ${SHELL##*/} == "zsh" ]]; then
    echo -e "${GREEN}ZSH settings:${NC}"
    chsh -s $(which zsh) && printf "${GREEN}Set ZSH as default!${NC}\n"

    cp    "${myPath}/backup/zshrc" ~/.zshrc
    cp -R "${myPath}/backup/zsh" ~/.config
fi 

cp -R "${myPath}/backup/nvim" ~/.config
cp    "${myPath}/backup/tmux.conf" ~/.tmux.conf
cp -R "${myPath}/backup/tex" ~/.config
cp    "${myPath}/colors.sh" ~/.config


# Add zoxide
# curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Add user to dialout
sudo adduser lukasz dialout 2> /dev/null

# Set default file size
gsettings set org.gnome.nautilus.window-state initial-size '(850,1050)'
 
# for EXT in $GNOME_EXTENSIONS; do
#     gnome-extensions install $EXT
# done


# Auto run hotspot:
# HOTSPOT="# Enable Hostspot\n \
# if [[ $( nmcli device status | awk '/enp3s0/{print $3}' ) == "połączono" ]]; then\n \
# \tif [[ $(nmcli device status | awk '/^wlo1/{print $3}') == "rozłączono" ]]; then\n \
# \t\tnmcli connection up Hotspot\n \
# \tfi\n \
# fi\n"
# 
# echo -e $HOTSPOT >> ~/.profile

echo -e "\a"
