FROM timonier/php:cli

LABEL \
    maintainer="Morgan AUCHEDE <morgan.auchede@gmail.com>"

ENV \
    PHPCI_VERSION=latest

RUN set -ex \
\
    # Install packages
\
    && apk add --no-cache --no-progress \
           bash \
\
    # Install block8/phpci
\
    && mkdir -p /opt \
    && git clone "https://github.com/Block8/PHPCI" /opt/phpci \
    && composer install --no-dev --optimize-autoloader --working-dir /opt/phpci \
    && chown -R www-data:www-data /opt/phpci \
\
    # Install phpmd/phpmd
\
    && curl --location --output /usr/local/bin/phpmd "http://static.phpmd.org/php/latest/phpmd.phar" \
    && chmod +x /usr/local/bin/phpmd \
\
    # Install sebastianbergmann/phploc
\
    && curl --location --output /usr/local/bin/phploc "https://phar.phpunit.de/phploc.phar" \
    && chmod +x /usr/local/bin/phploc \
\
    # Install squizlabs/PHP_CodeSniffer
    && curl --location --output /usr/local/bin/phpcs "https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar" \
    && chmod +x /usr/local/bin/phpcs \
\
    # Install timonier/dumb-entrypoint
\
    && curl --location "https://github.com/timonier/dumb-entrypoint/raw/master/src/s6-overlay/installer" | INSTALL_DIRECTORY="/usr/sbin" sh -s -- install \
    && curl --location "https://github.com/timonier/dumb-entrypoint/raw/master/src/syslog-stdout/installer" | INSTALL_DIRECTORY="/usr/sbin" sh -s -- install \
\
    # Clean
\
    && rm -f -r \
           /opt/phpci/.git \
           /opt/phpci/PHPCI/build \
           /root/.composer \
           /tmp/*

COPY ./rootfs /

ENTRYPOINT [ "/init" ]
