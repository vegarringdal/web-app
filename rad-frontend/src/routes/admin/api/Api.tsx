import { ApiLoader, getDataControllerByName, GridControllerButtons, SimpleHtmlGrid } from "@rad-tools";
import React, { useEffect, useState } from "react";
import json5 from "json5";

export function Api() {
    const controllerName = "WEB_REST_API";
    return (
        <ApiLoader
            controllerName={controllerName}
            callback={(controller) => {
                const gridInterface = controller.gridInterface;

                return (
                    <div className="flex flex-row h-full mt-2 w-full">
                        <div className="flex flex-col m-2">
                            <GridControllerButtons dataSet={controllerName} />
                        </div>
                        <SimpleHtmlGrid
                            className="simple-html-grid flex-grow m-3 mb-5"
                            interface={gridInterface}
                        ></SimpleHtmlGrid>
                        <Details controllerName={controllerName} />
                    </div>
                );
            }}
        ></ApiLoader>
    );
}

export function Details(props: { controllerName: string }) {
    const [data, setData] = useState({} as { NAME: string; DATA: string });
    const controller = getDataControllerByName(props.controllerName);
    const dataSource = controller.dataSource;

    type Details = { NAME: string; DATA: any };

    useEffect(() => {
        const datahandler = (e: { type: string; data: any }) => {
            if (e?.type === "currentEntity") {
                // generate new obj, so state see change
                const obj = {} as Details;
                obj.NAME = dataSource.currentEntity?.NAME;
                obj.DATA = dataSource.currentEntity?.DATA;

                obj.DATA = json5.stringify(json5.parse(obj.DATA), { space: 4 });
                setData(obj);
            }
            // to keep it
            return true;
        };

        dataSource.addEventListener(datahandler);

        return () => {
            dataSource.removeEventListener(datahandler);
        };
    });

    return (
        <div className="flex flex-col m-2 p-2 flex-1">
            <span className="p-2 m-2">API name: {data?.NAME}</span>
            <hr></hr>
            <button
                onClick={() => {
                    if (dataSource.currentEntity) {
                        dataSource.currentEntity.DATA = JSON.stringify(json5.parse(data.DATA));
                    }
                }}
                className="m-2 p-2 bg-gray-200 w-28  hover:bg-gray-300 focus:outline-none  dark:bg-gray-700  dark:hover:bg-gray-600 dark:text-blue-400 font-semibold"
            >
                Verify & Update
            </button>
            <span className="p-2 m-2 mb-0">API config json string:(use code IDE for editing..)</span>
            {/* 
                I need to make GUI interface or add better code editor: https://github.com/antonmedv/codejar
            */}
            <textarea
                value={data?.DATA || ""}
                onChange={(e) => {
                    const obj = Object.assign({}, data);
                    obj.DATA = e.target.value;
                    setData(obj);
                }}
                className="flex-1 p-2 m-2 mt-0  bg-gray-700 text-gray-200 outline-none"
            ></textarea>
        </div>
    );
}
