alias ls="ls --color=always"
alias ll="ls -a --color=always"
alias exit="exit 0"

export PS1="\[\e[36;40m\]\$WSL_DISTRO_NAME\[\e[m\]:\[\e[35;40m\]\w\[\e[m\] $ "

if [[ -n $WSL_DISTRO_NAME && -f /usr/bin/dockerd ]]; then
    # Start Docker daemon automatically when logging in if not running.
    RUNNING=`ps aux | grep dockerd | grep -v grep`
    if [ -z "$RUNNING" ]; then
        sudo dockerd > /dev/null 2>&1 &
        disown
    fi
fi

## doctl aliases
if [[ -f /usr/local/bin/doctl ]]; then
    alias docre='doctl compute d create --ssh-keys 96:37:19:bc:76:93:fd:d5:06:74:87:8f:15:0a:37:7c  --size s-1vcpu-1gb --image ubuntu-20-04-x64 --region fra1 testubuntu'
    alias dosizes='doctl compute size list'
    alias dols='doctl compute d ls'
    alias doimgs='doctl compute image list-distribution'
    alias doapps='doctl compute image list-application'
fi
