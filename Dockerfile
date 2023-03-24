FROM ubuntu:18.04 AS base

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y \
    apt-utils \
    usbutils \
    cups \
    libcups2-dev \
    libcupsimage2-dev

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt

COPY ./test-files /printers

WORKDIR /usr/lib/cups/filter
COPY ./cups/filter/. .
RUN chmod +x *

WORKDIR /usr/share/ppd/cupsfilters
COPY ./cups/ppd/. .
RUN chmod +x *.ppd

WORKDIR /etc/cups
COPY ./cups/cupsd.conf .

WORKDIR /
ENTRYPOINT ["/usr/sbin/cupsd", "-f"]
