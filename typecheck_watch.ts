import { TypeChecker } from "esbuild-helpers";

const app = TypeChecker({
    basePath: "./app-frontend",
    name: "app-frontend",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

app.printSettings();
app.inspectAndPrint();
app.worker_watch(["./", "../app-common/src", "../app-guitools/src"]);

const appBackend = TypeChecker({
    basePath: "./app-backend",
    name: "app-backend",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

appBackend.printSettings();
appBackend.inspectAndPrint();
appBackend.worker_watch("./");

const appCommon = TypeChecker({
    basePath: "./app-common",
    name: "app-common",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

appCommon.printSettings();
appCommon.inspectAndPrint();
appCommon.worker_watch("./");

const appTools = TypeChecker({
    basePath: "./app-tools",
    name: "app-tools",
    shortenFilenames: false,
    tsConfig: "./tsconfig.json"
});

appTools.printSettings();
appTools.inspectAndPrint();
appTools.worker_watch("./");

