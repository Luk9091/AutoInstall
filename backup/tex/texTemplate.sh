#! /usr/bin/zsh
local TEX_TEMPLATES=/home/lukasz/.config/tex
source ~/.config/zsh/colors.sh

function addVerticalPages(){
    local MY_PATH=$(pwd)
    if [ $1 ]; then
        MY_PATH=$1
    fi
    
    FILE="${MY_PATH}/main.tex"
    ADD_TO_MAIN='\\input{verticalPages.tex}'

    cp ${TEX_TEMPLATES}/verticalPages.tex ${MY_PATH}

    if [[ ! ( -e $FILE ) ]]; then
        echo -e "${RED}File main.tex not exist${NC}"
        echo -e "Remember to add ${ORANGE}${ADD_TO_MAIN}${NC} in your main.tex"
    else 
        if grep -Fxq "$ADD_TO_MAIN" "$FILE"; then
            echo "Tekst już istnieje w pliku."
            exit 0
        fi  

        LINE=$(awk '/^$/{print NR; exit}' "$FILE")
        # sed -i "/^$/ {s/^$/$ADD_TO_MAIN/; :a;n;ba}" "$FILE"
        sed -i "${LINE}s/^$/$ADD_TO_MAIN/" "$FILE"

        echo -e "${GREEN}Add vertical pages in line ${LINE}${NC}"
    fi
}

function createRaport(){
    local MY_PATH=$(pwd)
    if [ $1 ]; then
        MY_PATH=$1
    fi

    mkdir -p ${MY_PATH}/Img
    mkdir -p ${MY_PATH}/Chapters
    mkdir -p ${MY_PATH}/Measure

    if [[ ! ( -e "${MY_PATH}/main.tex" ) ]]; then
        cp ${TEX_TEMPLATES}/raport_template.tex ${MY_PATH}/main.tex
    else
        echo -e "${RED}File main.tex exist${NC}"
        echo -e "${ORANGE}Override? [y/N]${NC}"
        read -q CHECK
        
        if [[ $CHECK == 'y' ]] then
            cp ${TEX_TEMPLATES}/raport_template.tex ${MY_PATH}/main.tex
        fi
    fi
}

function createPrezentation(){
    local MY_PATH=$(pwd)
    if [ $1 ]; then
        MY_PATH=$1
    fi
    mkdir -p ${MY_PATH}/Img
    mkdir -p ${MY_PATH}/Chapters
    mkdir -p ${MY_PATH}/Measure

    if [[ ! ( -e "${MY_PATH}main.tex" ) ]]; then
        cp ${TEX_TEMPLATES}/prez.tex ${MY_PATH}/main.tex
    else
        echo -e "${RED}File main.tex exist${NC}"
        echo -e "${ORANGE}Override? [y/N]${NC}"
        read -q CHECK

        if [[ $CHECK == 'y' ]] then
            cp ${TEX_TEMPLATES}/prez.tex ${MY_PATH}/main.tex
        fi
    fi
}

