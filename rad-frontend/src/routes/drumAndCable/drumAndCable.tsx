import React from "react";
import { Link } from "react-router-dom";
import { Routes, Route } from "react-router";
import { Cable } from "./cable/cable";
import { Drum } from "./drum/drum";

export function DrumAndCable() {
    return (
        <div className="flex flex-col w-full">
            <div className="flex justify-center  m-2 p-2">
                <Link className="default-button" to="cable">
                    Cable
                </Link>
                <Link className="default-button" to="drum">
                    Drum
                </Link>
            </div>
            <div className="flex flex-1 m-2">
                <Routes>
                    <Route path="/cable" element={<Cable />}></Route>
                    <Route path="/drum" element={<Drum />}></Route>
                    <Route path="/" element={<Drum />}></Route>
                </Routes>
            </div>
        </div>
    );
}
