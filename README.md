# web-app

Experiment for web application using mulitirepo to try and share parts between applications. Will work more like a template instead of npm modules you use.

When you build it, you get 1 docker image/pod for backend and frontend (database oracle/redis not part of image)


Im not 100% sure how this will end🤪 and might just blow up 💣 before I managed to make anything useful 🤣 

Will be very messy in the begining, since I will pull inn existing projects/experiments to save time/reuse.


## web-app

Will be root of application, you will only edit name/url to repos.

TODO: make list of edits needed for new project
- package.json repo urls/name/dockerimage, versionrc.json url

This will pull inn all other repos

[repo](https://github.com/vegarringdal/web-app)


## web-app-backend

This will not be something you edit, just fork

Server hosting web page and database api

Will use nodejs as web hosting/api server

Will need redis as for session state, oracle for database (we use oracle at work...) and azure ad for userlogin (user only, access roles will be in database)


[repo](https://github.com/vegarringdal/web-app-backend)

## web-app-common

This will not be something you edit, just fork

Will be common code for config, and if any utils need to be shared between frontend and backend. 

This will need to be selfcontained/no external libs


[repo](https://github.com/vegarringdal/web-app-common)

## web-app-guitools

This will not be something you edit, just fork

This will be framework for frontend.

Will use react & vanillajs libs.

[repo](https://github.com/vegarringdal/web-app-guitools)

## web-app-frontend

This will be the part you fork template and edit.

Will be main application using the other parts as help

Will be react application

[repo](https://github.com/vegarringdal/web-app-frontend)



# How to get started (with this app)

- `git clone https://github.com/vegarringdal/web-app`
- `npm run gitclone`
- `npm install`
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