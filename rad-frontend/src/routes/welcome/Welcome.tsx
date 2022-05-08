import React from "react";
import { Link } from "react-router-dom";
import { guiStateController } from "@rad-tools";

export function Welcome() {
    const guiState = guiStateController();

    return (
        <div className="flex w-full flex-col">
            <div className="m-auto text-2xl p-2 mt-5">Welcome {guiState.currentUser}</div>
            <div className="m-auto  p-2 mt-5">
                This is a proof of concept page for grid/datasource for applications and dynamic rest api for report
                with CRUD oerations
            </div>
            <div className="m-auto flex mt-2">
                <div className="m-auto">
                    <Link
                        to="admin"
                        className="m-2 p-2 bg-gray-200 w-28  hover:bg-gray-300 focus:outline-none  dark:bg-gray-700  dark:hover:bg-gray-600 dark:text-blue-400 font-semibold"
                    >
                        Admin
                    </Link>
                    <Link
                        to="drumAndCable"
                        className="m-2 p-2 bg-gray-200 w-28  hover:bg-gray-300 focus:outline-none  dark:bg-gray-700  dark:hover:bg-gray-600 dark:text-blue-400 font-semibold"
                    >
                        Drum and cable
                    </Link>
                    <Link
                        to="dynamic"
                        className="m-2 p-2 bg-gray-200 w-28  hover:bg-gray-300 focus:outline-none  dark:bg-gray-700  dark:hover:bg-gray-600 dark:text-blue-400 font-semibold"
                    >
                        dynamic
                    </Link>
                </div>
            </div>
            {/*  this is just to push everything else up */}
            <div className="flex-1"></div>
        </div>
    );
}
