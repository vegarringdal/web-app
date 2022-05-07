import React from "react";
import { guiStateController } from "@rad-tools";

export function AdminLanding() {
    const guiState = guiStateController();

    return (
        <div className="flex w-full flex-col">
            <div className="m-auto text-2xl p-2 mt-5">Admin: {guiState.currentUser}</div>
            <span className="m-auto text-base">
                <b>Users:</b> Here you add or remove users
            </span>
            <span className="m-auto text-base">
                <b>Role:</b>Here you set application Roles
            </span>
            <span className="m-auto text-base">
                <b>Users Roles:</b> Assign role to user
            </span>
            <span className="m-auto text-base">
                <b>API:</b>Add dynamic API for reports
            </span>
            {/*  this is just to push everything else up */}
            <div className="flex-1"></div>
        </div>
    );
}
