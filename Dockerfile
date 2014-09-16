FROM ubuntu
MAINTAINER Adam Sheehan <a.t.sheehan@gmail.com>

RUN apt-get update
RUN apt-get install -y ruby2.0 ruby2.0-dev build-essential libpq-dev nodejs

RUN ln -sf /usr/bin/ruby2.0 /usr/bin/ruby
RUN ln -sf /usr/bin/gem2.0 /usr/bin/gem
RUN ln -sf /usr/bin/rake2.0 /usr/bin/rake
RUN ln -sf /usr/bin/erb2.0 /usr/bin/erb
RUN ln -sf /usr/bin/ri2.0 /usr/bin/ri
RUN ln -sf /usr/bin/rdoc2.0 /usr/bin/rdoc

ADD horizon_0.1-1_all.deb /tmp/horizon_0.1-1_all.deb
RUN dpkg -i /tmp/horizon_0.1-1_all.deb
