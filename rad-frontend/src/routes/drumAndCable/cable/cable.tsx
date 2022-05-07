import React from "react";
import { ApiLoader, getApiConfig, GridControllerButtons, SimpleHtmlGrid } from "@rad-tools";

export function Cable() {
    const controllerName = "CABLE";
    return (
        <ApiLoader
            controllerName={controllerName}
            callback={(controller) => {
                const gridInterface = controller.gridInterface;
                return (
                    <div className="flex flex-col w-full">
                        <span className="m-auto text-xl">{getApiConfig(controllerName).api.title}</span>

                        <div className="flex flex-row h-full mt-2 w-full">
                            <div className="flex flex-col m-2">
                                <GridControllerButtons dataSet={controllerName} />
                            </div>
                            <SimpleHtmlGrid
                                className="simple-html-grid flex-grow m-3 mb-5"
                                interface={gridInterface}
                            ></SimpleHtmlGrid>
                        </div>
                    </div>
                );
            }}
        ></ApiLoader>
    );
}
