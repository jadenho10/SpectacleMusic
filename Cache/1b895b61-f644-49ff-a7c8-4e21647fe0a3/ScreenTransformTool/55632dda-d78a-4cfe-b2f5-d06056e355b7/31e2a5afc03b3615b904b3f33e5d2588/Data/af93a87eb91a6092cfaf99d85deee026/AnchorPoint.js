"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AnchorPoint = void 0;
const SidePoint_1 = require("./SidePoint");
class AnchorPoint extends SidePoint_1.SidePoint {
    constructor(sceneObject) {
        super(sceneObject);
    }
    setPosition(position) {
        this.screenTransform.anchors.setCenter(position);
    }
}
exports.AnchorPoint = AnchorPoint;
//# sourceMappingURL=AnchorPoint.js.map