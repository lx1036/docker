FROM ubuntu:18.04
MAINTAINER lx1036@126.com

# Install requirements
RUN apt-get update -qq && apt-get install -qqy curl wget ca-certificates unzip ssh supervisor

# Install PHP and Nginx
RUN apt-get install git apt-transport-https daemontools \
    php7.3-fpm \
    php7.3-cli \
    php7.3-json \
    php7.3-intl \
    php7.3-curl \
    php7.3-xml \
    nginx \
    apache2-utils

# Configure PHP and Nginx
RUN mkdir /run/php && echo "daemon off;" >> /etc/nginx/nginx.conf

# Toran Proxy Version and Download
ENV TORAN_PROXY_VERSION 1.5.4
RUN curl -sL https://toranproxy.com/releases/toran-proxy-v${TORAN_PROXY_VERSION}.tgz | tar xzC /tmp \
    && mv /tmp/toran /var/www

# Load scripts for installing Toran Proxy
COPY scripts /scripts/toran-proxy
RUN chmod -R u+x /scripts/toran-proxy

# Load bin files
COPY bin /bin/toran-proxy/
RUN chmod -R u+x /bin/toran-proxy
ENV PATH $PATH:/bin/toran-proxy

# Load configurations(nginx,supervisor)
COPY config/nginx /etc/nginx/sites-available
COPY config/supervisor /etc/supervisor
COPY config/toran /assets

# Clean
RUN apt-get -qqy --purge autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME /data/toran-proxy

EXPOSE 80
EXPOSE 443

CMD /scripts/toran-proxy/launch.sh
