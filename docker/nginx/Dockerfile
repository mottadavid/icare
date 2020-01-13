FROM nginx:1.17.6-alpine

RUN apk add --update apache2-utils

ENV RAILS_ROOT /var/www/app

WORKDIR $RAILS_ROOT

RUN mkdir log

COPY docker/nginx/nginx.conf /tmp/app.conf
COPY docker/nginx/ssl/*.pem /etc/ssl/certs/

EXPOSE 80 443

COPY docker/nginx/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
