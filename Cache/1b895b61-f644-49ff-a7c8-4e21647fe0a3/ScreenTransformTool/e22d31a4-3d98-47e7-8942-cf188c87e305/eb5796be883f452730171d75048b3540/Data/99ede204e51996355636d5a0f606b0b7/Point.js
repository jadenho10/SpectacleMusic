"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Point = void 0;
const GizmoUtils_1 = require("../GizmoUtils");
class Point {
    constructor(sceneObject) {
        this.sceneObject = sceneObject;
        this.cameraSize = 20;
        this.zoom = 1;
        this.aabbMin = vec2.one().uniformScale(-1);
        this.aabbMax = vec2.one();
        this.screenTransform = sceneObject.getComponent("ScreenTransform");
        this.offset = this.screenTransform.anchors.getCenter();
        this.scale = this.screenTransform.scale;
        this.rotation = this.screenTransform.rotation;
        this.eventsScript = sceneObject.createComponent("ScriptComponent");
        this.interactionComponent = this.sceneObject.getComponent("InteractionComponent");
        if (!this.interactionComponent) {
            this.interactionComponent = this.sceneObject.createComponent("InteractionComponent");
        }
        this.interactionComponent.isFilteredByDepth = true;
        this.setupInteractions();
    }
    updateInteractionCamera(camera) {
        this.interactionComponent.setCamera(camera);
        const size = this.screenTransform.anchors.getSize().uniformScale(camera.size / this.cameraSize);
        this.screenTransform.anchors.setSize(size);
        this.screenTransform.scale = this.screenTransform.scale.uniformScale(camera.size / this.cameraSize);
        this.cameraSize = camera.size;
        this.interactionCamera = camera;
    }
    updateLayer(layer) {
        this.sceneObject.layer = layer;
    }
    setOnUpdate(callback) {
        this.callback = callback;
    }
    containsWorldPoint(point) {
        return this.containsScreenPoint(GizmoUtils_1.GizmoUtils.worldPointToScreenPoint(this.screenTransform, point));
    }
    containsScreenPoint(point) {
        const [min, max] = this.getAABBMinMax(); // It is this way to have consistency with InteractionComponent
        return (min.x <= point.x && point.x <= max.x) && (min.y <= point.y && point.y <= max.y);
    }
    setZoom(zoom) {
        this.zoom = zoom;
        this.screenTransform.scale = this.scale.uniformScale(zoom);
    }
    setScale(scale) {
        this.scale = scale;
        this.setZoom(this.zoom);
    }
    setValidator(callback) {
        this.validator = callback;
    }
    setupInteractions() { }
    getAABBMinMax() {
        const a = this.screenTransform.localPointToScreenPoint(GizmoUtils_1.GizmoUtils.TOP_LEFT);
        const b = this.screenTransform.localPointToScreenPoint(GizmoUtils_1.GizmoUtils.TOP_RIGHT);
        const c = this.screenTransform.localPointToScreenPoint(GizmoUtils_1.GizmoUtils.BOTTOM_LEFT);
        const d = this.screenTransform.localPointToScreenPoint(GizmoUtils_1.GizmoUtils.BOTTOM_RIGHT);
        this.aabbMin.x = Math.min(a.x, b.x, c.x, d.x);
        this.aabbMin.y = Math.min(a.y, b.y, c.y, d.y);
        this.aabbMax.x = Math.max(a.x, b.x, c.x, d.x);
        this.aabbMax.y = Math.max(a.y, b.y, c.y, d.y);
        return [this.aabbMin, this.aabbMax];
    }
}
exports.Point = Point;
//# sourceMappingURL=Point.js.map