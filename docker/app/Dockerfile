FROM ruby:2.7.0-alpine

RUN apk add --no-cache --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  postgis \
  postgresql-dev \
  tzdata \
  yarn

RUN gem install bundler --version "2.1.2"

ENV RAILS_ROOT /var/www/app

RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

RUN mkdir -p log
RUN mkdir -p tmp/pids

ARG RAILS_ENV
ENV RAILS_ENV=${RAILS_ENV:-production}
ENV RACK_ENV=${RAILS_ENV:-production}

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle config set deployment 'true' && bundle

COPY package.json package.json
COPY yarn.lock yarn.lock

RUN yarn

COPY app ./app
COPY bin ./bin
COPY config ./config
COPY db ./db
COPY lib ./lib
COPY public ./public
COPY .browserslistrc .browserslistrc
COPY .postcssrc.yml .postcssrc.yml
COPY babel.config.js babel.config.js
COPY config.ru ./config.ru
COPY postcss.config.js postcss.config.js
COPY Rakefile ./Rakefile

RUN SECRET_KEY_BASE=dummy DATABASE_URL=postgis:dummy rails assets:precompile

EXPOSE 3000

COPY docker/app/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
