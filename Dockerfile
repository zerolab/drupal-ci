FROM nginx:stable

MAINTAINER Dan Braghis <dan@zerolab.org>

WORKDIR /var/www/html
VOLUME /var/www/html

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/drupal8.conf /etc/nginx/conf.d/default.conf

ENV NGINX_SERVER_NAME="_"
ENV NGINX_DOCROOT="/var/www/html"

RUN sed -i 's@%NGINX_SERVER_NAME%@'"${NGINX_SERVER_NAME}"'@' /etc/nginx/conf.d/*.conf
RUN sed -i 's@%NGINX_DOCROOT%@'"${NGINX_DOCROOT}"'@' /etc/nginx/conf.d/*.conf

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
