import { aiCableApi } from "./aiCableApi";
import { aiDrumApi } from "./aiDrumApi";

// for user to add if needed
export function getAppConfig() {
    return [aiDrumApi, aiCableApi];
}
