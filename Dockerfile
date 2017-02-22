FROM resin/rpi-raspbian:jessie 
WORKDIR /root

RUN apt-get update  \
	&& apt-get -qy install curl \
		apt-utils \
		ca-certificates \
		python \
	&& curl -sL https://deb.nodesource.com/setup_6.x | /bin/bash -  \
	&& apt-get -y install nodejs \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/homebridge
RUN apt-get -q update \
	&& apt-get install -qy \
		avahi-daemon \
		build-essential \
    	dbus \
    	git \
    	libavahi-compat-libdnssd-dev \
    	libasound2-dev \
	&& npm install -g --unsafe-perm homebridge \
	&& mkdir -p /var/run/dbus \
	&& apt-get -qy remove \
		libavahi-compat-libdnssd-dev \
    	libasound2-dev \
	&& apt-get clean \
	&& apt-get autoremove \
	&& apt-get remove --purge build-essential \
	&& rm -rf /var/lib/apt/lists/*

RUN npm install -g homebridge-hue
RUN npm install -g homebridge-mqtt
RUN npm install -g homebridge-tadoheating
RUN npm install -g homebridge-wemo

RUN apt-get update
RUN apt-get install libavahi-compat-libdnssd1

ADD run.sh run.sh
RUN chmod +x run.sh
CMD ["./run.sh"]
