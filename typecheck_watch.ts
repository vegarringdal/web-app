import { TypeChecker } from "esbuild-helpers";

const app = TypeChecker({
    basePath: "./rad-frontend",
    name: "rad-frontend",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

app.printSettings();
app.inspectAndPrint();
app.worker_watch(["./src","../rad-common/src", "../rad-guitools/src"]);

const appBackend = TypeChecker({
    basePath: "./rad-backend",
    name: "rad-backend",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

appBackend.printSettings();
appBackend.inspectAndPrint();
appBackend.worker_watch("./src");

const appCommon = TypeChecker({
    basePath: "./rad-common",
    name: "rad-common",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

appCommon.printSettings();
appCommon.inspectAndPrint();
appCommon.worker_watch("./src");

const appTools = TypeChecker({
    basePath: "./rad-guitools",
    name: "rad-guitools",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

appTools.printSettings();
appTools.inspectAndPrint();
appTools.worker_watch("./src");
