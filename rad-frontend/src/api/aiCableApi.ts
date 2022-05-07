import { ApiInterface } from "@rad-common";

export const aiCableApi: ApiInterface = {
    apiName: "CABLE",
    viewName: "AI_CABLE",
    title: "Cable Types",
    project: null,
    accessUpdate: ["API_ADMIN"],
    accessInsert: ["API_ADMIN"],
    accessDelete: ["API_ADMIN"],
    modified: "MODIFIED",
    primaryKey: "ID",
    columns: [
        {
            name: "CTYPE",
            type: "text"
        },
        {
            name: "DIM",
            type: "text"
        },
        {
            name: "CABLETYPE",
            type: "text"
        },
        {
            name: "MODIFIED",
            type: "date",
            accessUpdate: []
        },
        {
            name: "MODIFIED_BY",
            type: "text",
            accessUpdate: []
        },
        {
            name: "CREATED",
            type: "date",
            accessUpdate: []
        },
        {
            name: "CREATED_BY",
            type: "text",
            accessUpdate: []
        }
    ]
};
