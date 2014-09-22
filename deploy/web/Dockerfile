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

RUN apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD tmp/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT service nginx start
