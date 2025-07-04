#!/usr/bin/zsh

USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}
USER_NAME=${USER_NAME:-user}
GROUP_NAME=${GROUP_NAME:-group}

userdel -r ubuntu > /dev/null 2>&1
groupadd -g ${GROUP_ID} ${GROUP_NAME} > /dev/null 2>&1
useradd -u ${USER_ID} -g ${GROUP_NAME} -G sudo -o -m ${USER_NAME} -s /usr/bin/zsh > /dev/null 2>&1
export HOME=/home/${USER_NAME}
touch $HOME/.zshrc
chown $USER_NAME:$GROUP_NAME $HOME

# change owner for install packages using uv
chown $USER_NAME:$GROUP_NAME /usr/local/python
chown $USER_NAME:$GROUP_NAME /usr/local/python/bin
chown $USER_NAME:$GROUP_NAME /usr/local/python/share
chown $USER_NAME:$GROUP_NAME /usr/local/python/share/man/man1
chown $USER_NAME:$GROUP_NAME /usr/local/python/lib/python*/site-packages

if [[ $# -eq 0 ]]; then
    exec /usr/sbin/gosu ${USER_NAME} zsh
else
    /usr/sbin/gosu ${USER_NAME} "$@"
fi
