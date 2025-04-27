"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.resetCursorTexture = exports.setCursorTexture = exports.setInfo = exports.unlock = exports.lock = exports.lastRotation = exports.lastCursorID = void 0;
const CursorData_1 = require("./CursorData");
exports.lastCursorID = "";
exports.lastRotation = 0;
let requestsQueue = [];
let cursorsStack = [];
let idToTexture = {};
let isActiveProcessing = false;
let isLocked = false;
function lock() {
    isLocked = true;
}
exports.lock = lock;
function unlock() {
    isLocked = false;
}
exports.unlock = unlock;
function setInfo(id, rotation) {
    if (isLocked) {
        return;
    }
    exports.lastCursorID = id;
    exports.lastRotation = rotation;
}
exports.setInfo = setInfo;
function setCursorTexture(id, texture) {
    if (isLocked) {
        return;
    }
    exports.lastCursorID = id;
    createOrUpdateCursor(id, texture);
    // if (id === last(cursorsStack)) {
    requestsQueue.push([CursorData_1.RequestType.SetCursor, texture]);
    // }
    if (!isActiveProcessing && requestsQueue.length) {
        startProcessing();
    }
}
exports.setCursorTexture = setCursorTexture;
function resetCursorTexture(id) {
    if (isLocked) {
        return;
    }
    exports.lastCursorID = "";
    // const idx = cursorsStack.indexOf(id);
    // cursorsStack.splice(idx, 1);
    // if (idx !== cursorsStack.length) {
    //     return;
    // }
    // if (cursorsStack.length) {
    //     requestsQueue.push([RequestType.SetCursor, idToTexture[last(cursorsStack)]]);
    // } else {
    requestsQueue.push([CursorData_1.RequestType.UnsetCursor, null]);
    // }
    if (!isActiveProcessing) {
        startProcessing();
    }
}
exports.resetCursorTexture = resetCursorTexture;
function startProcessing() {
    isActiveProcessing = true;
    const request = requestsQueue.shift();
    performRequest(request[0], request[1]).then(() => {
        if (requestsQueue.length) {
            startProcessing();
        }
        else {
            isActiveProcessing = false;
        }
    }).catch((err) => {
        print("Failed to perform request " + request[0] + ". Reason: " + err);
    });
}
function createOrUpdateCursor(id, texture) {
    let cursorIdx = cursorsStack.indexOf(id);
    if (cursorIdx < 0) {
        cursorsStack.push(id);
    }
    idToTexture[id] = texture;
}
async function performRequest(requestType, texture = null) {
    const request = RemoteApiRequest.create();
    request.endpoint = requestType;
    if (requestType === CursorData_1.RequestType.SetCursor) {
        if (!texture) {
            throw new Error("No Texture Provided For Cursor");
        }
        request.uriResources = [await convertTexture(texture)];
    }
    CursorData_1.CursorRemoteServiceModule.performApiRequest(request, (response) => {
        if (response.statusCode !== 200) {
            print("Cursor request failed: " + response.body);
        }
    });
}
function last(arr) {
    return arr[arr.length - 1];
}
async function convertTexture(texture) {
    //@ts-ignore
    return CursorData_1.CursorRemoteMediaModule.createImageResourceForTexture(texture, CursorData_1.CursorTextureUploadOptions);
}
//# sourceMappingURL=CursorModule.js.map