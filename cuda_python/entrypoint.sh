#!/usr/bin/zsh

USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}
USER_NAME=${USER_NAME:-user}
GROUP_NAME=${GROUP_NAME:-group}

groupadd -g ${GROUP_ID} ${GROUP_NAME} > /dev/null 2>&1
useradd -u ${USER_ID} -g ${GROUP_NAME} -G sudo -o -m ${USER_NAME} -s /usr/bin/zsh > /dev/null 2>&1
echo "${USER_NAME}:${USER_NAME}" | chpasswd
export HOME=/home/${USER_NAME}
chown $USER_NAME:$GROUP_NAME $HOME

touch $HOME/.zshrc
echo 'export PATH='"~/.local/bin:$PATH" >> $HOME/.zshrc
chown $USER_NAME:$GROUP_NAME $HOME/.zshrc

CMD="${@:-zsh}"
exec /usr/sbin/gosu ${USER_NAME} /usr/bin/zsh -c $CMD
