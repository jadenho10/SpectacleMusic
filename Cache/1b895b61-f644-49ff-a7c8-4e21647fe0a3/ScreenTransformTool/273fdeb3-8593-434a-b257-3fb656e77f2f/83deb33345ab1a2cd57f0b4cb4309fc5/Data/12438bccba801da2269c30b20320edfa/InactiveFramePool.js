"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.InactiveFramePool = void 0;
const Utils_1 = require("./Utils");
class InactiveFramePool {
    constructor(inactiveFrameRef, poolSize) {
        this.inactiveFrameRef = inactiveFrameRef;
        this.poolSize = poolSize;
        this.pool = [];
        this.defaultInteractionCamera = null;
        this.lastActiveFrame = null;
    }
    getNewInactiveFrame() {
        if (this.pool.length < this.poolSize) {
            this.resetPool();
        }
        const frame = this.pool.pop();
        this.spawnNewInactiveFrame();
        frame.show();
        return frame;
    }
    setDefaultInteractionCamera(camera) {
        this.defaultInteractionCamera = camera;
    }
    resetPool() {
        this.pool = [];
        for (let i = 0; i < this.poolSize; i++) {
            this.spawnNewInactiveFrame();
        }
    }
    spawnNewInactiveFrame() {
        const newCopy = this.inactiveFrameRef.copy();
        if (this.defaultInteractionCamera) {
            newCopy.setInteractionCamera(this.defaultInteractionCamera);
        }
        newCopy.setOnHover(() => {
            if (!isNull(this.lastActiveFrame) && !this.lastActiveFrame.isSame(newCopy)) {
                this.lastActiveFrame.setInactive();
            }
            this.lastActiveFrame = newCopy;
        });
        newCopy.setLayerSet(newCopy.getLayerSet().union(Utils_1.Utils.SYSTEM_LAYER));
        this.pool.push(newCopy);
    }
}
exports.InactiveFramePool = InactiveFramePool;
//# sourceMappingURL=InactiveFramePool.js.map