FROM ruby:2.7.0-alpine3.11
USER root
ENV LANG C.UTF-8
ARG ROOT_PATH=/myapp
ARG BUILD_PACKAGES="build-base curl git"
ARG DEV_PACKAGES="libxml2-dev libxslt-dev mysql mysql-dev mysql-client less yaml-dev zlib-dev nodejs yarn bash"
ARG RUBY_PACKAGES="tzdata yaml"

WORKDIR $ROOT_PATH

# install packages
RUN apk update \
 && apk upgrade \
 && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES 

# install rubygem
COPY Gemfile Gemfile.lock $ROOT_PATH/
RUN gem update bundler
RUN bundle install -j4

# install node_module
COPY package.json yarn.lock $ROOT_PATH/
RUN yarn install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
COPY . $ROOT_PATH

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
