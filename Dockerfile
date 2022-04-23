FROM node:16

# update/replace with 2 step build ? use oracle image and copy drivers ?
WORKDIR /tmp
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get install -y alien libaio1
# https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient21/x86_64/ <- check
RUN wget https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient21/x86_64/getPackage/oracle-instantclient-basiclite-21.4.0.0.0-1.x86_64.rpm
RUN alien -i --scripts oracle-instantclient*.rpm
RUN rm -f oracle-instantclient21.4*.rpm && apt-get -y autoremove && apt-get -y clean


WORKDIR /usr/src/app

# copy files we need
COPY package*.json ./
COPY config_defaults.ts ./
COPY tsconfig*.json ./

# copy main folders
COPY rad-server rad-server
COPY rad-common rad-common
COPY rad-server rad-server
COPY rad-guitools rad-guitools


# make sure we have newest npm
RUN npm install -g npm

## install/build and expose/test run
RUN npm install
RUN npm run build

## todo: make own image step, so we dont include dev dependencies in image?


# do not run as root
COPY --chown=node:node . /usr/src/app
USER node

EXPOSE 80
CMD [ "node", "./rad-server/dist/index.js" ]