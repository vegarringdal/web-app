# web-rad

Experiment for web application using mulitirepo to try and share parts between applications. Will work more like a
template instead of npm modules you use.

When you build it, you get 1 docker image/pod for backend and frontend (database oracle/redis not part of image)

Im not 100% sure how this will end🤪 and might just blow up 💣 before I managed to make anything useful 🤣

Will be very messy in the begining, since I will pull inn existing projects/experiments to save time/reuse.

It will also have a lot of commits as I try and built something I want to use, so I will be changing my mind as I find out what works and dont

## web-rad

Will be root / frontend of the application

This will pull inn all other repos `web-rad-backend`, `web-rad-common` and `web-rad-guitools`

* `rad-frontend` folder contains the react application you make

Some minor edits will need to be done one root folder

* package.json name & dockerImage
* .versionrc url
* add `.env` file for db


[repo](https://github.com/vegarringdal/web-rad)


## web-rad-backend

This will not be something you edit, just fork

Server hosting web page and database api

Will use nodejs as web hosting/api server

Will use oracle for database (we use oracle at work...) and azure ad for userlogin (user only + 2 default admins, access roles will be in
database)

Everyhting will be built for using updatable views with instead of update on oracle. Atm only limit Ive seen is not
beeing able to use returning in inserts

[repo](https://github.com/vegarringdal/web-rad-backend)

## web-rad-common

This will not be something you edit, just fork

Will be common code for config, and if any utils need to be shared between frontend and backend.

This will need to be selfcontained/no external libs


[repo](https://github.com/vegarringdal/web-rad-common)

## web-rad-guitools

This will not be something you edit, just fork

This will be framework for frontend.

Will use react & vanillajs libs.

[repo](https://github.com/vegarringdal/web-rad-guitools)



# How to get started (with this app)

-   `git clone https://github.com/vegarringdal/web-rad`
-   open workspace file.
-   `npm run clone` (first time only, next time its `npm run pull` if you need to update all)
-   `npm install` (so sub repo gets all installed..)

-   start oracle express

    -   create folder called `oracleExpress` on c disk
    -   create folder called `setup` & `startup`
    -   add this file `user_testdb.sql` under `setup` with content

              alter session set "_ORACLE_SCRIPT"=true;

              CREATE USER TESTDB
              IDENTIFIED by TESTDB
              QUOTA UNLIMITED ON users;

              GRANT ALL PRIVILEGES TO TESTDB;

    -   Then run: docker run --name oracle_db -p 1522:1521 -e ORACLE_PWD=admin -v
        c:/oracleExpress/data:/opt/oracle/oradata -v c:/oracleExpress/setup:/opt/oracle/scripts/setup -v
        c:/oracleExpress/startup:/opt/oracle/scripts/startup vegarringdal/oracledb-express-21.3.0:1.0.0

One liner:

-   `docker run --name oracle_db -p 1522:1521 -e ORACLE_PWD=admin -v c:/oracleExpress/data:/opt/oracle/oradata -v c:/oracleExpress/setup:/opt/oracle/scripts/setup -v c:/oracleExpress/startup:/opt/oracle/scripts/startup vegarringdal/oracledb-express-21.3.0:1.0.0`
-   next time you should be able to start with `docker start oracle_db`

next add `.env` to root

```bash
# db connections
AZURE_CLIENT_ID=add_your_own_ID
AZURE_TENDANT_ID=add_your_tendantid
# do not use graph scope, we will not be able to verify it, you need to use "expose an API"
AZURE_SCOPES=api://clientID/some api you have

# logs (console logs out useful dev info)
CONSOLE_SELECT=true
CONSOLE_INFO=true

```

```bash
# rad-server

# http server
SERVER_PORT         # default: 1080 - uses 1081 in dev mode, since its only API server
SERVER_HOST         # default: 0.0.0.0
SERVER_API_ROOT     # default: /api - vitejs also uses this for proxy settings

# DEVELOPMENT ONLY
PORT_API:           # default : 1081 - Will be used by application-server when it just a api server and vitejs
PORT_WEB:           # default : 1080 - Will be used by vitejs dev server

# FOR THIS rad-server
CONSOLE_INFO                # default: false -> TODO: lets add some levels
CONSOLE_SELECT              # default: false
DB_FETCH_SIZE               # default: 150
DB_PREFETCH_SIZE            # default: 150
DB_POOL_MAX                 # default: 5
DB_POOL_MIN                 # default: 2
DB_POOL_PING_INTERVAL       # default: 60
DB_POOL_TIMEOUT             # default: 120

DB_CONNECTION_CLIENT_ID     # default: PUBLIC-USER
DB_CONNECTION_CLIENT_INFO   # default: WWW.SAMPLE.COM
DB_CONNECTION_MODULE        # default: WWW.SAMPLE.COM  -> sending host name would be useful..
DB_CONNECTION_DB_OP         # default: WEB-UPDATE
DB_CONNECTION_ACTION        # NA - NOT IN USE -> APP IS SENDING IN 'READ' or 'MODIFY' so roles can be more limited


DB_USERNAME                 # default TESTDB
DB_PASSWORD                 # default TESTDB
DB_CONNECTION_STRING        # default (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1522))(CONNECT_DATA=(SERVICE_NAME=xe)))


# Azure - https://login.microsoftonline.com/
AZURE_CLIENT_ID             # default: UNKNOW ID
AZURE_TENDANT_ID            # default: UNKNOW ID
AZURE_SCOPES                # default : user.read  --> use comma to split

ACTIVATE_AZURE_FAKE_SUCCESS # default false;
AZURE_FAKE_ROLES: string[]  # no default, add with comma to split



```
