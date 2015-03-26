FROM       cine/base-image-docker

MAINTAINER Thomas Shafer <thomas@cine.io>

# make sure the ffmpeg transcoding log file exists
# RUN touch /var/run/haproxy.pid

WORKDIR /usr/src
RUN git clone https://github.com/hashicorp/consul-template.git
WORKDIR /usr/src/consul-template
RUN make

RUN apt-get install -y haproxy

# copy our service
RUN mkdir /service
COPY service/bin /service/bin
COPY service/config/haproxy.ctmpl /service/config/haproxy.ctmpl

# copy empty config to the haproxy default
COPY service/config/empty-haproxy-config.cfg /etc/haproxy/haproxy.cfg
# enable haproxy (default disabled because there is no default config that works)
COPY service/config/haproxy.default.conf /etc/default/haproxy

# start the service
WORKDIR /service
CMD ["/service/bin/run"]

# configuration
# for http
EXPOSE 80
# for stats
EXPOSE 8000
