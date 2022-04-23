import { TypeChecker } from "esbuild-helpers";

const app = TypeChecker({
    basePath: "./rad-frontend",
    name: "rad-frontend",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

app.printSettings();
app.inspectAndPrint();

const appTools = TypeChecker({
    basePath: "./rad-guitools",
    name: "rad-guitools",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

appTools.printSettings();
appTools.inspectAndPrint();

const appBackend = TypeChecker({
    basePath: "./rad-backend",
    name: "rad-backend",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

appBackend.printSettings();
appBackend.inspectAndPrint();

const appCommon = TypeChecker({
    basePath: "./rad-common",
    name: "rad-common",
    tsConfig: "./tsconfig.json",
    throwOnSemantic: true,
    throwOnSyntactic: true
});

appCommon.printSettings();
appCommon.inspectAndPrint();

