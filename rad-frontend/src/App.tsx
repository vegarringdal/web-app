import React from "react";
import "./App.css";
import { DropDownDialog, themeStateController } from "@rad-tools";
import { ActivateGridDarkTheme } from "@rad-tools";
import { initDarkTheme } from "@rad-tools";
import { LoadingDialog } from "@rad-tools";
import { ErrorDialog } from "@rad-tools";
import { RelatedDataDialog } from "@rad-tools";
import { AuthLoader } from "@rad-tools";
import { Router } from "./components/Router";

initDarkTheme();

export function App() {
    const theme = themeStateController();

    return (
        <div className="app bg-gray-100 dark:bg-gray-800 dark:text-white">
            <ActivateGridDarkTheme enabled={theme.darktheme}></ActivateGridDarkTheme>
            <RelatedDataDialog />
            <LoadingDialog />
            <ErrorDialog />
            <DropDownDialog />
            <AuthLoader>
                <Router />
            </AuthLoader>
        </div>
    );
}

export default App;
