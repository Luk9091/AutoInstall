# Prompt:
function setprompt(){
	setopt PROMPT_SUBST

        PPYTHON=""
        END_SING="$"
        if [[ $(which python3) != /usr/bin/python3 ]]; then
            PPYTHON=$(which python3 | awk -F'/bin/python3' '{print $1}' | awk -F'/' '{print $NF}')
            PPYTHON="($PPYTHON) "
            END_SING="🐍"
        fi

	if git status > /dev/null 2>&1
	then
		DIFF=$(git diff 2>&1)
		if [ ! -z $DIFF ]; then
			STATUS="✗"
			COLOR=#800000
			TEXT=#FFC0C0
		else
			STATUS="✔"
			COLOR=#005faf
			TEXT=green
		fi
		
		BRANCH=" %F{$TEXT}%K{$COLOR}($STATUS $(git status | awk '{print $NF}' | sed 1q))%k%f"
	else
		BRANCH=""
	fi

        TIME="%D{%H:%M:%S}"

	PROMPT='${TIME} ${PPYTHON}%B%F{green}%n@%M%f%b:%F{blue}%1~%f${BRANCH}${END_SING} '
}




function preexec(){
    TIME=$(date +"%H:%M:%S")
    echo -en "\033[1A"
    echo -e "${YELLOW}${TIME}${NC}"
}
