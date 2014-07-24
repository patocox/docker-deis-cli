FROM ubuntu:14.04
MAINTAINER CenturyLinkLabs

#Install dependencies for Wetty
RUN apt-get -qqy update && \
 apt-get -qqy install git nodejs npm && \
 ln -s /usr/bin/nodejs /usr/bin/node

#Install Wetty and set password
RUN git clone https://github.com/krishnasrinivas/wetty
WORKDIR /wetty
RUN npm install && \
 apt-get install -y vim && \
 useradd -d /home/term -m -s /bin/bash term && \
 echo 'term:term' | chpasswd

#Install Deis CLI
ADD https://s3-us-west-2.amazonaws.com/opdemand/deis-deb-wheezy-0.9.0.tgz /
RUN tar zxf /deis-deb-wheezy-0.9.0.tgz && mv deis /bin/deis

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "3000"]
