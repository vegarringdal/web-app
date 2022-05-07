import React from "react";
import { Link } from "react-router-dom";
import { Routes, Route } from "react-router";
import { AccessUserRole } from "./userRole/AccessUserRole";
import { AccessRole } from "./role/AccessRole";
import { AccessUser } from "./user/accessUser";
import { AdminLanding } from "./adminLanding/AdminLanding";
import { Api } from "./api/Api";

export function Admin() {
    return (
        <div className="flex flex-col w-full">
            <div className="flex justify-center  m-2 p-2">
                <Link className="default-button" to="user">
                    Users
                </Link>
                <Link className="default-button" to="role">
                    Roles
                </Link>
                <Link className="default-button" to="userrole">
                    Users Role
                </Link>
                <Link className="default-button" to="api">
                    Api
                </Link>
            </div>
            <div className="flex flex-1 m-2">
                <Routes>
                    <Route path="/user" element={<AccessUser />}></Route>
                    <Route path="/role" element={<AccessRole />}></Route>
                    <Route path="/userrole" element={<AccessUserRole />}></Route>
                    <Route path="/api" element={<Api />}></Route>
                    <Route path="/" element={<AdminLanding />}></Route>
                </Routes>
            </div>
        </div>
    );
}
