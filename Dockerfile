FROM ubuntu:22.04 AS base

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    apt-utils \
    usbutils \
    cups \
    libcups2-dev \
    libcupsimage2-dev

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt

COPY ./cups /install/cups

WORKDIR /install/cups
RUN cp -f cupsd.conf /etc/cups/cupsd.conf
RUN rm -r /install

CMD ["/usr/sbin/cupsd", "-f"]
