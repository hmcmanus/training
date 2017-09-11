#!/bin/bash

set -e

# variables
S3_URL=s3://xxx-dojo/cf101/

handle_error() {
    echo "ERROR: $1"
    exit 1
}

create_user() {
    echo "Creating user $1"
    /usr/sbin/useradd -m $1
    mkdir /home/$1/.ssh
    /bin/chown $1:$1 /home/$1/.ssh
    /bin/chmod 700 /home/$1/.ssh/
}

sync_keys() {
    echo "Syncing keys from S3"
    aws s3 sync ${S3_URL} /root/ssh_working_dir/
}

user_exists() {
    ret=1
    getent passwd $1 >/dev/null 2>&1 && ret=0
    return $ret
}

user_access() {
    echo "Allowing user to access this jumpbox"
    cat /root/ssh_working_dir/$1.pub >> /home/$1/.ssh/authorized_keys
    /bin/chmod 600 /home/$1/.ssh/authorized_keys
    /bin/chown $1:$1 /home/$1/.ssh/authorized_keys
    cp /root/.ssh/dojo-key.pem /home/$1/.ssh/
    /bin/chown $1:$1 /home/$1/.ssh/dojo-key.pem
}

sync_keys

for f in /root/ssh_working_dir/*.pub
do
    FILE_IN_DIR=${f##*/}
    USER=${FILE_IN_DIR%%.*}

    if $(user_exists $USER);then
        echo "User $USER exists"
    else
        create_user $USER
        user_access $USER
    fi
done

echo "Finished"