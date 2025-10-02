#!/bin/bash

WORKSPACE=/home/runner/workspace
USER_HOME=$HOME

mkdir -p $USER_HOME/.config/openbox
mkdir -p $USER_HOME/.config/tint2

cp $WORKSPACE/rc.xml $USER_HOME/.config/openbox/ 2>/dev/null || true
cp $WORKSPACE/menu.xml $USER_HOME/.config/openbox/ 2>/dev/null || true
cp $WORKSPACE/tint2rc $USER_HOME/.config/tint2/ 2>/dev/null || true
cp $WORKSPACE/autostart.sh $USER_HOME/.config/openbox/autostart 2>/dev/null || true

chmod +x $USER_HOME/.config/openbox/autostart 2>/dev/null || true
chmod +x $WORKSPACE/easy-novnc 2>/dev/null || true

if [ ! -f "$USER_HOME/.java_setup" ]; then
    echo "export JAVA_HOME=\$(dirname \$(dirname \$(readlink -f \$(which java))))" >> $USER_HOME/.bashrc
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> $USER_HOME/.bashrc
    touch $USER_HOME/.java_setup
fi

echo "Entorno configurado correctamente para $USER"
