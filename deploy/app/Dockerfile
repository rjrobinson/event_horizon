FROM ubuntu
MAINTAINER Adam Sheehan <a.t.sheehan@gmail.com>

RUN apt-get update
RUN apt-get install -y ruby2.0 libpq5 nodejs

RUN ln -sf /usr/bin/ruby2.0 /usr/bin/ruby
RUN ln -sf /usr/bin/gem2.0 /usr/bin/gem
RUN ln -sf /usr/bin/rake2.0 /usr/bin/rake
RUN ln -sf /usr/bin/erb2.0 /usr/bin/erb
RUN ln -sf /usr/bin/ri2.0 /usr/bin/ri
RUN ln -sf /usr/bin/rdoc2.0 /usr/bin/rdoc

ADD tmp/horizon_amd64.deb /tmp/horizon_amd64.deb
RUN dpkg -i /tmp/horizon_amd64.deb

USER horizon

ENV BUNDLE_GEMFILE /usr/share/horizon/Gemfile
ENV RAILS_ENV production

EXPOSE 5000

ENTRYPOINT bundle exec unicorn /usr/share/horizon/config.ru -c /usr/share/horizon/config/unicorn.rb -p 5000
