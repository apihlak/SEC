FROM alpine:3.10

WORKDIR /app

ADD https://github.com/simple-evcorr/sec/releases/download/2.8.2/sec-2.8.2.tar.gz /app/sec.tar.gz
RUN tar xvfz sec.tar.gz --strip-components=1 && rm -f sec.tar.gz

RUN mkdir -p rules logs perl

ADD ./rules/ /app/rules/
ADD ./perl/ /app/perl/

RUN apk update && apk add \
        rsyslog \
	perl \
        perl-json && \
	rm -rf /var/cache/apk/*

ADD ./config/rsyslog.conf /etc/rsyslog.conf

EXPOSE 514/tcp 514/udp

ENTRYPOINT ["rsyslogd", "-n", "-f", "/etc/rsyslog.conf"]

