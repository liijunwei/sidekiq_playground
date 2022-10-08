FROM ruby:alpine

RUN apk update \
    && apk add bash build-base redis tzdata \
    && mkdir /project

WORKDIR /project

COPY . .

RUN gem install bundler --no-document \
    && bundle update --bundler \
    && bundle install

CMD ["bundle", "exec", "rake", "worker"]
