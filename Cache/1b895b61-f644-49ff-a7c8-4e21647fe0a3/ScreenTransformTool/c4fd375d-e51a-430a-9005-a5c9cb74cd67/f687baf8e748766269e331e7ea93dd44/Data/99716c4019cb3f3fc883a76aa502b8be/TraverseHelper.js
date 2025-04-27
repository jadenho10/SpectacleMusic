"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TraverseHelper = void 0;
class TraverseHelper {
    constructor() {
        this.inTime = {};
        this.outTime = {};
        this.time = 0;
    }
    setRoot(root) {
        this.inTime = {};
        this.outTime = {};
        this.time = 1;
        this.initRoot(root);
    }
    isInHierarchy(root, object) {
        const rootId = root.uniqueIdentifier;
        const objectId = object.uniqueIdentifier;
        if (!this.inTime[rootId] || !this.inTime[objectId]) {
            return false;
        }
        return this.inTime[rootId] <= this.inTime[objectId]
            && this.outTime[objectId] <= this.outTime[rootId];
    }
    initRoot(root) {
        this.inTime[root.uniqueIdentifier] = this.time++;
        root.children.forEach((child) => {
            this.initRoot(child);
        });
        this.outTime[root.uniqueIdentifier] = this.time++;
    }
}
exports.TraverseHelper = TraverseHelper;
//# sourceMappingURL=TraverseHelper.js.map