#!/bin/bash

USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}
USER_NAME=${USER_NAME:-user}
GROUP_NAME=${GROUP_NAME:-group}

groupadd -g ${GROUP_ID} ${GROUP_NAME} > /dev/null 2>&1
useradd -u ${USER_ID} -g ${GROUP_NAME} -G sudo -o -m ${USER_NAME} -s /bin/bash > /dev/null 2>&1
echo "${USER_NAME}:${USER_NAME}" | chpasswd
export HOME=/home/${USER_NAME}
chown $USER_NAME:$GROUP_NAME $HOME

touch $HOME/.bashrc
echo 'export PATH='"~/.local/bin:$PATH" >> $HOME/.bashrc
chown $USER_NAME:$GROUP_NAME $HOME/.bashrc

# cd /onnx-tensorrt && python setup.py install > /dev/null 2>&1
cd $HOME

if [[ $# -eq 0 ]]; then
    exec /usr/sbin/gosu ${USER_NAME} bash
else
    /usr/sbin/gosu ${USER_NAME} "$@"
fi
