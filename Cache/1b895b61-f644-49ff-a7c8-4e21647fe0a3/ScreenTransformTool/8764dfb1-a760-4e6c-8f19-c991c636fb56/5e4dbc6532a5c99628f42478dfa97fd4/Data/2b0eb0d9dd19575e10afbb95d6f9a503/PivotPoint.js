"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PivotPoint = void 0;
const SidePoint_1 = require("./SidePoint");
class PivotPoint extends SidePoint_1.SidePoint {
    constructor(sceneObject) {
        super(sceneObject);
    }
    setPosition(position) {
        this.screenTransform.anchors.setCenter(position);
    }
}
exports.PivotPoint = PivotPoint;
//# sourceMappingURL=PivotPoint.js.map