#!/usr/bin/with-contenv /bin/sh

if [ ! -f /var/www/.ssh/id_rsa ] ; then
    ssh-keygen -N '' -b 4096 -f /var/www/.ssh/id_rsa -t rsa > /dev/null
    chown -R www-data:www-data /var/www/.ssh
fi

exit 0
