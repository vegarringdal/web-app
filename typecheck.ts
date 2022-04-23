import { TypeChecker } from "esbuild-helpers";

const app = TypeChecker({
    basePath: "./app-frontend",
    name: "app-frontend",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

app.printSettings();
app.inspectAndPrint();

const appTools = TypeChecker({
    basePath: "./app-guitools",
    name: "app-guitools",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

appTools.printSettings();
appTools.inspectAndPrint();

const appBackend = TypeChecker({
    basePath: "./app-backend",
    name: "app-backend",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

appBackend.printSettings();
appBackend.inspectAndPrint();

const appCommon = TypeChecker({
    basePath: "./app-common",
    name: "app-common",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

appCommon.printSettings();
appCommon.inspectAndPrint();

