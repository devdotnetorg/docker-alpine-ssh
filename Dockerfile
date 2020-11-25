########################
# Official Image Alpine with sshd
# Allow SSH connection to the container
# Installed: openssh-server, mc,htop,
# for net: ping, traceroute, telnet, host,
# nslookup, iperf, nmap
########################

FROM alpine:3.12
MAINTAINER DevDotNet.Org <anton@devdotnet.org>
LABEL maintainer="DevDotNet.Org <anton@devdotnet.org>"

#Base
# Set the locale

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Password for ssh
ENV PSWD=123456

#Copy to image
COPY copyables /

#Install
RUN apk update \
	&& apk add --no-cache bash sed mc htop openssh-server \
#Net utils
	&& apk add --no-cache iputils paris-traceroute perl-net-telnet bind-tools iperf nmap \
#Cleaning
	&& rm -rf /var/lib/{cache,log}/ \
	&& rm -rf /var/lib/apt/lists/*.lz4 \	
	&& rm -rf /var/log/* \	
	&& rm -rf /tmp/* /var/tmp/* \	
	&& rm -rf /usr/share/doc/ \
	&& rm -rf /usr/share/man/ \	
	&& rm -rf /var/cache/apk/* \	
	&& chmod +x /entrypoint.sh \
#Ssh
	&& ssh-keygen -A
	
#Main
#Folder Data
VOLUME /data

#port SSH
EXPOSE 22/tcp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]