import { ApiInterface } from "@rad-common";

export const aiDrumApi: ApiInterface = {
    apiName: "DRUM",
    viewName: "AI_DRUM",
    title: "Cable Drums",
    project: null,
    accessUpdate: ["API_ADMIN"],
    accessInsert: ["API_ADMIN"],
    accessDelete: ["API_ADMIN"],
    modified: "MODIFIED",
    primaryKey: "ID",
    columns: [
        {
            name: "TNAME",
            type: "text"
        },
        {
            name: "CABLETYPE_ID",
            type: "text",
            parentColumnsFromTo: [["_", "CABLETYPE"]]
        },
        {
            name: "CABLETYPE",
            type: "text",
            // RELATED
            parentViewApi: "CABLE",
            parentTitle: "Select drum cabletype",
            parentFrom: "ID",
            parentTo: "CABLETYPE_ID",
            parentColumnsFromTo: [
                ["CABLETYPE", "CABLETYPE"],
                ["ID", "CABLETYPE_ID"]
            ]
        },
        {
            name: "DRUM_RECIVED",
            type: "date",
            setAsOptionalInGrid: true
        },
        {
            name: "LENGTH_RECIVED",
            type: "number",
            readOnlyGrid: true
        },
        {
            name: "LENGTH_LOST",
            type: "number",
            removeFromGrid: true
        },
        {
            name: "USE_METERMARKING",
            type: "text",
            // CHECKBOX
            isCheckbox: true,
            checkboxChecked: "1",
            checkboxUnchecked: ""
        },
        {
            name: "COMMENT_FOREMAN",
            type: "text"
        },
        {
            name: "COMMENT_STORAGE",
            type: "text",
            parentViewApi: "CABLE",
            parentViewType: "DROPDOWN",
            parentTitle: "Select drum cabletype",
            parentFrom: "ID",
            parentTo: "CABLETYPE_ID",
            parentColumnsFromTo: [
                ["CABLETYPE", "CABLETYPE"],
                ["ID", "CABLETYPE_ID"]
            ]
        },
        {
            name: "LOCATION",
            type: "text"
        },
        {
            name: "LOCATION_COMMENT",
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
