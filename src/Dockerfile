FROM debian:jessie
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    DEBIAN_FRONTEND=noninteractive \
    PHPCI_VERSION=1.7.0 \
    S6_OVERLAY_VERSION=1.17.1.2 \
    SYSLOG_STDOUT_VERSION=1.1.1

RUN set -x \

    # Prepare system

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
           sudo \

    && curl -ksL "https://getcomposer.org/installer" | php -- --install-dir=/usr/bin \
    && mv /usr/bin/composer.phar /usr/bin/composer \

    # Install phpci

    && rm -rf /var/www/* \

    && curl -ksL "https://github.com/Block8/PHPCI/archive/v$PHPCI_VERSION.tar.gz" | tar fxz - -C /var \
    && mv "/var/PHPCI-$PHPCI_VERSION" /var/www \
    && sh -c "cd /var/www && composer install --no-dev --optimize-autoloader" \
    && mkdir /var/www/.ssh \
    && chown -R www-data:www-data /var/www \

    # Install s6-overlay

    && curl -ksL "https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz" | tar fxz - -C / \

    # Install syslog-stdout

    && curl -ksL "https://github.com/timonier/syslog-stdout/releases/download/v$SYSLOG_STDOUT_VERSION/syslog-stdout.tar.gz" | tar fxz - -C /usr/sbin \

    # Clean

    && rm -rf \
           /root/.composer \
           /tmp/* \
           /usr/bin/composer \
           /usr/share/nginx \
           /var/lib/apt/lists/*

COPY ./rootfs /

ENTRYPOINT [ "/init" ]
