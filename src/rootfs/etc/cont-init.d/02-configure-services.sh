#!/usr/bin/with-contenv /bin/sh

rm -rf /etc/services.d

if [ "worker" = "$PHPCI_MODE" ] ; then
    ln -s /etc/services.worker.d /etc/services.d
else
    ln -s /etc/services.phpci.d /etc/services.d
fi

exit 0
