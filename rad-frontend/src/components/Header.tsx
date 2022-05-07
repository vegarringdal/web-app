import React from "react";
import { themeStateController } from "@rad-tools";
import { guiStateController } from "@rad-tools";
import { DarkModeIcon } from "@rad-tools";
import { useNavigate } from "react-router";

export function Header() {
    const theme = themeStateController();
    const guiState = guiStateController();
    const navigate = useNavigate();

    return (
        <header className="block text-center text-xl p-1 m-1 bg-gray-200 dark:bg-gray-700 dark:text-white ">
            <div className="focus:outline-none text-sm absolute left-0 ml-5 flex">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-6 w-6 "
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    onClick={() => {
                        navigate("/");
                    }}
                >
                    <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                    />
                </svg>
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-6 w-6 focus:outline-none text-sm absolute left-0 ml-10"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    onClick={() => guiState.activateProfileDialog()}
                >
                    <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                </svg>
            </div>
            Web Update
            <button
                className="focus:outline-none absolute right-0 mr-5"
                onClick={() => {
                    theme.toggleDarkMode();
                }}
            >
                <DarkModeIcon />
            </button>
        </header>
    );
}
