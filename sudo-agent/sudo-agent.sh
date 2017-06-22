if [ -z "$SSH_AUTH_SOCK" ]; then
    echo "no agent available..."
    exit -1
fi
sudo su -l -c "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SUDO_SSH_USER=$USER; /bin/bash;"

