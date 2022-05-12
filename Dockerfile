FROM oraclelinux:8 as builder

# use tmp folder and get wget and oracle client -> then install
WORKDIR /tmp
RUN dnf -y install wget
RUN wget https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient21/x86_64/getPackage/oracle-instantclient-basiclite-21.4.0.0.0-1.x86_64.rpm
RUN dnf -y install oracle-instantclient-basiclite-21.4.0.0.0-1.x86_64.rpm

# remove parts we dont need
RUN rm -rf /usr/lib/oracle/21/client64/bin
WORKDIR /usr/lib/oracle/21/client64/lib/
RUN rm -rf *jdbc* *occi* *mysql* *jar

# not use the nodejs image
FROM node:16

#copy oracle client
COPY --from=builder /usr/lib/oracle /usr/lib/oracle
COPY --from=builder /usr/share/oracle /usr/share/oracle
COPY --from=builder /etc/ld.so.conf.d/oracle-instantclient.conf /etc/ld.so.conf.d/oracle-instantclient.conf

# update system & install libaio1
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get install -y libaio1 && \
    apt-get -y autoremove && apt-get -y clean && \
    ldconfig

WORKDIR /usr/src/app

# copy files we need
COPY package*.json ./
COPY tsconfig*.json ./

# copy main folders
COPY rad-backend rad-backend
COPY rad-common rad-common
COPY rad-frontend rad-frontend
COPY rad-guitools rad-guitools


# make sure we have newest npm
RUN npm install -g npm

## install/build and expose/test run
RUN npm install
RUN npm run build
RUN rm -rf node_modules/
RUN npm install --ignore-scripts --omit=dev
## todo: make own image step, so we dont include dev dependencies in image?


# do not run as root
COPY --chown=node:node . /usr/src/app
USER node

EXPOSE 80
CMD [ "node", "./rad-backend/dist/index.js" ]