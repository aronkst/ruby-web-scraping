FROM ruby:3.1.0-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential chromium \
  && apt-get clean

RUN gem update --system && gem install bundler

WORKDIR /usr/src/app

COPY Gemfile .
COPY Gemfile.lock .
COPY *.rb .

RUN bundle install --jobs 4

CMD ["ruby", "server.rb"]
