FROM ruby:2.7.1

RUN apt-get update -qq &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
  apt-get install -y golang-go build-essential libpq-dev nodejs &&\
  useradd --user-group --create-home --shell /bin/false app

ENV HOME=/home/app
USER app
RUN go get github.com/mailhog/MailHog
COPY --chown=app:app Gemfile Gemfile.lock $HOME/wedding/
WORKDIR $HOME/wedding
RUN bundle

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]

COPY --chown=app:app . $HOME/wedding/
