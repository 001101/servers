if [ -z "$SSH_AUTH_SOCK" ]; then
    echo "
==========NOTICE==========

no ssh agent was provided via SSH_AUTH_SOCK (forward agent?), performing a 'sudo su' instead

=========================="
    sudo su
else
    sudo su -l -c "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SUDO_SSH_USER=$USER; /bin/bash;"
fi
