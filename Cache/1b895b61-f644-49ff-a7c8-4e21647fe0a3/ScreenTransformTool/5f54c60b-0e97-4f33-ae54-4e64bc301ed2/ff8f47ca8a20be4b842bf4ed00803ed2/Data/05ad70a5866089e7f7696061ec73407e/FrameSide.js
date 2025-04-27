"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FrameSide = void 0;
class FrameSide {
    constructor(sceneObject) {
        this.sceneObject = sceneObject;
        this.zoom = 1;
        this.scale = vec2.one();
        this.screenTransform = this.sceneObject.getComponent("ScreenTransform");
        this.offsetSize = this.screenTransform.offsets.getSize();
    }
    setVisualZoom(zoom) {
        this.zoom = zoom;
        this.screenTransform.offsets.setSize(this.offsetSize.mult(this.scale).uniformScale(this.zoom));
    }
    setVisualScale(scaleX, scaleY) {
        this.scale.x = scaleX;
        this.scale.y = scaleY;
        this.setVisualZoom(this.zoom);
    }
    updateLayer(layer) {
        this.sceneObject.layer = layer;
        this.sceneObject.getChild(0).layer = layer;
    }
}
exports.FrameSide = FrameSide;
//# sourceMappingURL=FrameSide.js.map