FROM ruby:alpine

RUN apk update && apk add bash build-base redis tzdata
# RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata

RUN mkdir /project
WORKDIR /project

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.20 --no-document
RUN bundle install

COPY . .

CMD ["bundle", "exec", "rake", "worker"]
