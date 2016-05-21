FROM debian:jessie
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    GOSU_VERSION=1.7 \
    PHPCI_VERSION=1.7.0 \
    S6_OVERLAY_VERSION=1.17.1.2 \
    SYSLOG_STDOUT_VERSION=1.1.1

RUN set -x \

    # Prepare system

    && export DEBIAN_FRONTEND=noninteractive \

    && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list.d/nginx.list \
    && apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && apt-get update \

    # Install packages

    && apt-get install -y --no-install-recommends \
           ca-certificates \
           curl \
           git \
           nginx \
           openssh-client \
           php5-cli \
           php5-curl \
           php5-fpm \
           php5-json \
           php5-mysqlnd \
           net-tools \

    && curl -sL "https://getcomposer.org/installer" | php -- --install-dir=/usr/bin \
    && mv /usr/bin/composer.phar /usr/bin/composer \

    # Configure nginx

    && mkdir -p /var/tmp/nginx \
    && chown www-data:www-data /var/tmp/nginx \

    # Configure www-data

    && mkdir -p /var/www \
    && chown www-data:www-data /var/www \

    # Install gosu

    && curl -sLo /usr/sbin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64"  \
    && chmod +x /usr/sbin/gosu \

    # Install phpci

    && curl -sL "https://github.com/Block8/PHPCI/archive/v$PHPCI_VERSION.tar.gz" | tar fxz - -C /usr/share \
    && mv /usr/share/PHPCI-$PHPCI_VERSION /usr/share/phpci \
    && chown www-data:www-data /usr/share/phpci/PHPCI/build \

    && composer install --no-dev --optimize-autoloader --working-dir /usr/share/phpci \
    && composer require --optimize-autoloader --update-no-dev --working-dir /usr/share/phpci block8/php-docblock-checker \
    && composer require --optimize-autoloader --update-no-dev --working-dir /usr/share/phpci mauchede/atoum-phpci-plugin \
    && composer require --optimize-autoloader --update-no-dev --working-dir /usr/share/phpci mauchede/sami-phpci-plugin \

    # Install s6-overlay

    && curl -sL "https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz" | tar fxz - -C / \

    # Install syslog-stdout

    && curl -sL "https://github.com/timonier/syslog-stdout/releases/download/v$SYSLOG_STDOUT_VERSION/syslog-stdout.tar.gz" | tar fxz - -C /usr/sbin \

    # Clean

    && rm -rf \
           /etc/nginx/conf.d/default.conf \
           /etc/php5/fpm/pool.d/www.conf \
           /root/.composer \
           /tmp/* \
           /usr/bin/composer \
           /usr/local/bin \
           /usr/share/nginx \
           /var/lib/apt/lists/*

COPY ./rootfs /

ENTRYPOINT [ "/init" ]
