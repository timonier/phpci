#!/usr/bin/with-contenv /bin/sh

cat > /var/www/PHPCI/config.yml << EOF
b8:
    database:
        servers:
            read: ${PHPCI_DB_HOST:-mysql}
            write: ${PHPCI_DB_HOST:-mysql}
        name: ${PHPCI_DB_NAME:-$MYSQL_ENV_MYSQL_DATABASE}
        username: ${PHPCI_DB_USER:-$MYSQL_ENV_MYSQL_USER}
        password: ${PHPCI_DB_PASSWORD:-$MYSQL_ENV_MYSQL_PASSWORD}
phpci:
    url: "${PHPCI_URL:-http://$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1 }')}"
    worker:
        host: ${PHPCI_QUEUE_HOST:-beanstalkd}
        queue: ${PHPCI_QUEUE_NAME:-phpci}
EOF

chown www-data:www-data /var/www/PHPCI/config.yml

exit 0
