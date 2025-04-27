"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PanControl = void 0;
const LensRegion_1 = require("./LensRegion");
class PanControl {
    constructor(script, screenTransform) {
        this.doOnUpdate = [];
        this.script = script;
        this.screenTransform = screenTransform;
        this.cameraObject = this.getCameraObject(this.screenTransform.getSceneObject());
        this.cameraTransform = this.cameraObject.getTransform();
        this.initPosition = screenTransform.anchors.getCenter();
        this.startPosition = screenTransform.anchors.getCenter();
        this.setupEvents();
    }
    addOnUpdateCallback(cb) {
        this.doOnUpdate.push(cb);
    }
    resetPosition() {
        this.screenTransform.anchors.setCenter(this.initPosition);
        this.computeCameraPosition();
        this.startPosition = this.screenTransform.anchors.getCenter();
        this.cameraStartPosition = this.cameraTransform.getWorldPosition();
        this.processCallbacks();
    }
    getWorldDelta() {
        return this.cameraTransform.getWorldPosition();
    }
    forceUpdate(resetStartPositions = false) {
        this.computeCameraPosition();
        if (resetStartPositions) {
            this.startPosition = this.screenTransform.anchors.getCenter();
            this.cameraStartPosition = this.cameraTransform.getWorldPosition();
        }
    }
    processCallbacks() {
        this.doOnUpdate.forEach((cb) => {
            cb && cb();
        });
    }
    getCameraObject(object) {
        if (object.getComponent("Component.Camera")) {
            return object;
        }
        if (object.hasParent()) {
            return this.getCameraObject(object.getParent());
        }
        return null;
    }
    computeCameraPosition() {
        const screenCenter = this.screenTransform.screenPointToLocalPoint(new vec2(0.5, 0.5));
        const diff = this.screenTransform.localPointToWorldPoint(vec2.zero())
            .sub(this.screenTransform.localPointToWorldPoint(screenCenter)).uniformScale(-1);
        this.cameraTransform.setWorldPosition(diff);
    }
    setupEvents() {
        let isActive = false;
        const handlePanTranslation = (translation) => {
            translation.y = -translation.y;
            this.screenTransform.anchors.setCenter(this.startPosition.add(translation.uniformScale(2)));
            this.computeCameraPosition();
            this.processCallbacks();
        };
        const onPanStartEvent = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy) {
                return;
            }
            LensRegion_1.LensRegion.isBusy = true;
            isActive = true;
            handlePanTranslation(eventData.getTranslation());
        };
        const onPanMoveEvent = (eventData) => {
            if (!isActive) {
                return;
            }
            handlePanTranslation(eventData.getTranslation());
        };
        const onPanEndEvent = (eventData) => {
            if (!isActive) {
                return;
            }
            handlePanTranslation(eventData.getTranslation());
            this.startPosition = this.screenTransform.anchors.getCenter();
            this.cameraStartPosition = this.cameraTransform.getWorldPosition();
            LensRegion_1.LensRegion.isBusy = false;
            isActive = false;
        };
        this.script.createEvent("PanGestureStartEvent").bind(onPanStartEvent);
        this.script.createEvent("PanGestureMoveEvent").bind(onPanMoveEvent);
        this.script.createEvent("PanGestureEndEvent").bind(onPanEndEvent);
    }
}
exports.PanControl = PanControl;
//# sourceMappingURL=PanControl.js.map