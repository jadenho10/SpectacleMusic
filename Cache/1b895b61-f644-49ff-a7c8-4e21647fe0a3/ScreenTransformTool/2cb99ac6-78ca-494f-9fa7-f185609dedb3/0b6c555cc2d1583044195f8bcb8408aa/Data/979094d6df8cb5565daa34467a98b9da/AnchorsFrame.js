"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AnchorsFrame = void 0;
const GizmoUtils_1 = require("./GizmoUtils");
class AnchorsFrame {
    constructor(screenTransform, frameSide, anchorPoints) {
        this.screenTransform = screenTransform;
        this.frameSide = frameSide;
        this.anchorPoints = anchorPoints;
        this.offsets = screenTransform.offsets;
        this.anchors = screenTransform.anchors;
        this.baseScreenTransform = screenTransform.getSceneObject().getParent().getComponent("ScreenTransform");
    }
    setVisualZoom(zoom) {
        this.anchorPoints.forEach(point => point.setZoom(zoom));
        this.frameSide.forEach(frame => frame.setVisualZoom(zoom));
    }
    setVisualScale(scale) {
        // this.anchorPoints.forEach(point => point.setScale(scale));
        // this.frameSide.forEach(frame => frame.setVisualScale(scale.x, scale.y))
    }
    updateLayer(layer) {
        this.frameSide.forEach(frame => frame.updateLayer(layer));
    }
    updateTransform(rootScreenTransform) {
        const worldAnchorCenter = GizmoUtils_1.GizmoUtils.parentPointToWorldPoint(rootScreenTransform, rootScreenTransform.anchors.getCenter());
        const inverseScale = rootScreenTransform.scale;
        inverseScale.x = 1 / inverseScale.x;
        inverseScale.y = 1 / inverseScale.y;
        inverseScale.z = 1 / inverseScale.z;
        this.baseScreenTransform.scale = inverseScale;
        this.screenTransform.rotation = rootScreenTransform.rotation.invert();
        this.offsets.left = -rootScreenTransform.offsets.left;
        this.offsets.right = -rootScreenTransform.offsets.right;
        this.offsets.top = -rootScreenTransform.offsets.top;
        this.offsets.bottom = -rootScreenTransform.offsets.bottom;
        this.offsets.setCenter(vec2.zero());
        this.anchors.setCenter(this.screenTransform.worldPointToParentPoint(worldAnchorCenter));
    }
}
exports.AnchorsFrame = AnchorsFrame;
//# sourceMappingURL=AnchorsFrame.js.map