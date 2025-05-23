#! /bin/bash
apt=dnf
APT_PACK=true
PYTHON_LIB=true
FLAT_PACK=false

source colors.sh
source packages.sh

if [[ $APT_PACK == true ]]; then
    for package in $PACKAGES; do
        (sudo $apt install $package -y && echo -e "${GREEN}Successful installed $package${NC}") || (( echo -e "${RED}Failed install $package${NC}" && echo -e ${package} >> errorInstall ))
    done
fi

if [[ $APT_PACK == true ]]; then
    echo "${ORANGE}Install python lib${NC}"
    for lib in $PYTHON_LIB; do
        (sudo $apt install $lib -y && echo -e "${GREEN}Successful installed $lib${NC}") || echo -e "${RED}Failed install $lib${NC}"
    done
fi

if [[ $APT_PACK == true ]]; then
    echo "${ORANGE}Install flats${NC}"
    for flat in $FLATS; do
        (sudo flatpak install $flat -y && echo -e "${GREEN}Successful installed $flat${NC}") || echo -e "${RED}Failed install $flat${NC}"
    done
fi
