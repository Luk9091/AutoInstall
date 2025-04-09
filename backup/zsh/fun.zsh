source '/home/lukasz/.config/zsh/functions/connection.sh'


function timeof() {
    start=$(date +%s.%6N)
    "$@"
    end=$(date +%s.%6N)
    runtime=$(( (end - start) * 1000000 ))
    printf "Run time: %.6f µs\n" ${runtime}
}

function mkcd(){
    mkdir -p $@ && cd ${@:$#}
}

function mkco(){
    mkdir -p $@ && cd ${@:$#} && code .
}

function about(){
    if [[ $# -eq 0 ]]; then
        info --vi-keys $(fc -nl -1)
    else
        info --vi-keys $@
    fi
}


function cd(){
    zcd $@ 
    if [[ $? == "0" ]]; then
        if [[ $PWD == "${HOME}"* ]]; then
            echo -e "${ORANGE}~${PWD#$HOME}${NC}"
        else
            echo -e "${ORANGE}${PWD}${NC}"
        fi
    fi
}

function co(){
    cd $@ && code .
}
