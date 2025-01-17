#! /usr/bin/bash
source /home/lukasz/.config/zsh/colors.sh


# Alias:
alias reload="source ~/.zshrc && printf '${RED}Reload shell${NC}\n'"
alias clr=clear
alias fclr="clear && printf '\e[3J' && clear"

alias toClipboard="xclip -selection clipboard"
alias MSI=/opt/DriversAndScripts/MSI-Dragon-Center-for-Linux-main/./MSI_run.sh
alias python=python3
# alias ise=/opt/Xilinx/14.7/ISE_DS/./iseRun.sh
alias aghVPN="sudo openvpn ~/.config/VPN-AGH.2024.ovpn"

alias ok='sudo $(fc -nl -1)'
alias rm="trash"
alias rmdir="trash"
alias mkdir="mkdir -p"
alias ls="ls --color"
alias la="ls --color -la"
alias ...="popd >> /dev/null && cd ."
alias terminal="gnome-terminal ."

alias zshrc="${EDITOR} ~/.zshrc"
alias tmuxcfg="${EDITOR} ~/.tmux.conf"
alias colorslst="${EDITOR} ~/.config/zsh/colors.sh"

alias fun_zsh="${EDITOR} ~/.config/zsh/fun.zsh"
alias als_zsh="${EDITOR} ~/.config/zsh/als.zsh"
alias reload_als="source ~/.config/zsh/als.zsh && printf '${RED}Reload aliasys${NC}\n'"
alias reload_fun="source ~/.config/zsh/fun.zsh && printf '${RED}Reload functions${NC}\n'"

alias story="${EDITOR} ~/.cache/zsh/history"


# Monitor
alias brightness="sudo ddcutil setvcp 10"
# Keyboard
alias keyboard="sudo -b /opt/DriversAndScripts/apex7tkl_linux/./cli.py"


# PICO SDK
alias PICOprobe='openocd -f interface/cmsis-dap.cfg -c "adapter speed 5000" -f target/rp2040.cfg -s tcl'


