# web-rad

Experiment for web application using mulitirepo to try and share parts between applications. Will work more like a template instead of npm modules you use.

When you build it, you get 1 docker image/pod for backend and frontend (database oracle/redis not part of image)


Im not 100% sure how this will end🤪 and might just blow up 💣 before I managed to make anything useful 🤣 

Will be very messy in the begining, since I will pull inn existing projects/experiments to save time/reuse.


## web-rad

Will be root of application, you will only edit name/url to repos.

TODO: make list of edits needed for new project
- package.json repo urls/name/dockerimage, versionrc.json url

This will pull inn all other repos

[repo](https://github.com/vegarringdal/web-rad)


## web-rad-backend

This will not be something you edit, just fork

Server hosting web page and database api

Will use nodejs as web hosting/api server

Will need redis as for session state, oracle for database (we use oracle at work...) and azure ad for userlogin (user only, access roles will be in database)


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

## web-rad-frontend

This will be the part you fork template and edit.

Will be main application using the other parts as help

Will be react application

[repo](https://github.com/vegarringdal/web-rad-frontend)



# How to get started (with this app)

- `git clone https://github.com/vegarringdal/web-rad`
- open workspace file.
- `npm install`
- `npm run gitclone`
- `npm install` (so sub repo gets all installed..)
- start redis `docker run -p 6379:6379 -d redis`
- start oracle express
    - create folder called `oracleExpress` on c disk
    - create folder called `setup` & `startup`
    - add this file `user_testdb.sql` under `setup` with content          
            
            alter session set "_ORACLE_SCRIPT"=true;

            CREATE USER TESTDB
            IDENTIFIED by TESTDB
            QUOTA UNLIMITED ON users;
            
            GRANT ALL PRIVILEGES TO TESTDB;
    - Then run:
            
            docker run
                --name oracle_db
                -p 1522:1521
                -e ORACLE_PWD=admin
                -v c:/oracleExpress/data:/opt/oracle/oradata
                -v c:/oracleExpress/setup:/opt/oracle/scripts/setup
                -v c:/oracleExpress/startup:/opt/oracle/scripts/startup
                vegarringdal/oracledb-express-21.3.0:1.0.0

One liner:
* `docker run --name oracle_db -p 1522:1521 -e ORACLE_PWD=admin -v c:/oracleExpress/data:/opt/oracle/oradata -v c:/oracleExpress/setup:/opt/oracle/scripts/setup -v c:/oracleExpress/startup:/opt/oracle/scripts/startup vegarringdal/oracledb-express-21.3.0:1.0.0`
* next time you should be able to start with `docker start oracle_db`



```bash
# rad-server

# http server
SERVER_PORT         # default: 1080 - uses 1081 in dev mode, since its only API server
SERVER_HOST         # default: 0.0.0.0
SERVER_COMPRESSION  # default: true
SERVER_API_ROOT     # default: /api - vitejs also uses this for proxy settings

# express session
SESSION_MAX_AGE     # default: 864000000
SESSION_DOMAIN      # default: 0.0.0.0
SESSION_PRIVATE_KEY # default: change_me
SESSION_NAME        # default: session_name
SESSION_HTTP_ONLY   # default: true
SESSION_SAME_SITE   # default: true
SESSION_SECURE      # default is set by esbuild - default true if not development

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
DB_CONNECTION_ACTION        # NOT IN USE -> SENDING REPORT NAME


# Azure - https://login.microsoftonline.com/
AZURE_CLIENT_ID             # default: UNKNOW ID
AZURE_TENDANT_URI           # no default... Sample: https://login.microsoftonline.com/{TENDANTID}  (authority part of config)
AZURE_SECRET                # default : UPER SECRET
AZURE_SCOPES                # default : user.read  --> use comma to split
ACTIVATE_AZURE_FAKE_SUCCESS # default false;
AZURE_FAKE_ROLES: string[]  # no default, add with comma to split

## access view, wil contain roles
ACCESS_DB                   # default: DEFAULT
ACCESS_VIEW                 # default: WEB_ACCESS_VIEW

# Here we supply just names of connection
# Use comma to split them
DB_CONNECTIONS_NAMES_ARRAY  # default: DEFAULT

# Environment variable names only!
# Use comma to split them
DB_USERNAME_ARRAY           # default: DEFAULT_DB_USERNAME
DB_CONNECTION_STRING_ARRAY  # default: DEFAULT_DB_CONNECTION_STRING
DB_PASSWORD_ARRAY           # default: DEFAULT_DB_PASSWORD


####################################
# Minimal usage with all defaults:
####################################

# usename and password
DEFAULT_DB_USERNAME=DEFAULT_USER
DEFAULT_DB_PASSWORD=PASSWORD
DEFAULT_DB_CONNECTION_STRING=SOME.TNSNAME
# default view/page
DEFAULT_VIEW_DB_NAME=DEFAULT
DEFAULT_VIEW_DB_SCHEMA=DEFAULT_USER
DEFAULT_VIEW_DB_OBJECT=MY_REPORT_VIEW

# if no TNS (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=xe)))
# todo, add wallet sample..


# azure hack for development (need restart if you edit)
#ACTIVATE_AZURE_FAKE_SUCCESS=true
#AZURE_FAKE_ROLES=WORKPREP_007900_READ,WORKPREP_007900_DELETE,WORKPREP_007900_INSERT,WORKPREP_007900_UPDATE

# or azure for production
AZURE_CLIENT_ID=ID
AZURE_TENDANT_URI=https://login.microsoftonline.com/TENTANT_ID
AZURE_SECRET=SECRET_STRING
AZURE_SCOPES=user.read


```