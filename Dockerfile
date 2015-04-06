FROM postgres
MAINTAINER Chad Schmutzer <schmutze@amazon.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update && \
  apt-get -y -q dist-upgrade && \
  apt-get -y -q install rsyslog python-setuptools python-pip curl groff

RUN echo "*.* @@cloudwatchlogs:515" > /etc/rsyslog.d/cloudwatchlogs.conf

RUN pip install supervisor
COPY supervisord.conf /usr/local/etc/supervisord.conf

CMD ["/usr/local/bin/supervisord"]
