"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AspectControl = void 0;
class AspectControl {
    constructor(script, windowResolution, lensResolution, screenTransform) {
        this.anchors = Rect.create(-1, 1, -1, 1);
        this.center = vec2.zero();
        this.lastResolution = [0, 0];
        this.doOnUpdate = [];
        this.isLensStudioPreviewResolutionEnabled = false;
        this.windowResolution = windowResolution;
        this.lensResolution = lensResolution;
        this.aspect = this.lensResolution.control.getAspect();
        this.screenTransform = screenTransform;
        this.script = script;
        this.updateEvent = this.script.createEvent("UpdateEvent");
        this.updateEvent.bind(() => {
            if (this.checkForChange()) {
                this.onUpdate();
            }
        });
    }
    updateLensResolution(texture) {
        this.lensResolution = texture;
        this.aspect = this.lensResolution.control.getAspect();
        this.onUpdate();
    }
    addOnUpdateCallback(cb) {
        this.doOnUpdate.push(cb);
    }
    getAspect() {
        return this.lensResolution.control.getAspect();
    }
    getShrinkScale() {
        if (this.getAspect() < 1) {
            return (this.anchors.top - this.anchors.bottom) / 2;
        }
        return (this.anchors.right - this.anchors.left) / 2;
    }
    setLensStudioPreviewResolution(isEnabled) {
        this.isLensStudioPreviewResolutionEnabled = isEnabled;
    }
    setAspect(aspect) {
        this.aspect = aspect;
        this.onUpdate();
    }
    onUpdate() {
        this.updateLensRegion();
        this.updateAnchors();
        this.processCallbacks();
    }
    processCallbacks() {
        this.doOnUpdate.forEach((cb) => {
            cb && cb();
        });
    }
    updateLensRegion() {
        const bWidth = this.lastResolution[0];
        const bHeight = this.lastResolution[1];
        this.center = this.screenTransform.anchors.getCenter();
        this.screenTransform.anchors.left = -1;
        this.screenTransform.anchors.right = 1;
        this.screenTransform.anchors.top = 1;
        this.screenTransform.anchors.bottom = -1;
        if (this.windowResolution.control.getAspect() < this.aspect) {
            const k = bWidth / this.aspect / bHeight;
            this.screenTransform.anchors.bottom = -k;
            this.screenTransform.anchors.top = k;
        }
        else {
            const k = bHeight * this.aspect / bWidth;
            this.screenTransform.anchors.left = -k;
            this.screenTransform.anchors.right = k;
        }
        this.anchors = Rect.create(this.screenTransform.anchors.left, this.screenTransform.anchors.right, this.screenTransform.anchors.bottom, this.screenTransform.anchors.top);
        this.anchors.setCenter(this.center);
    }
    getLensAspect() {
        return this.lensResolution.control.getAspect();
    }
    checkForChange() {
        if (this.lastResolution[0] !== this.windowResolution.getWidth() ||
            this.lastResolution[1] !== this.windowResolution.getHeight()) {
            this.lastResolution = [this.windowResolution.getWidth(), this.windowResolution.getHeight()];
            return true;
        }
        return false;
    }
    updateAnchors(zoom = 1) {
        this.screenTransform.anchors.left = this.anchors.left * zoom;
        this.screenTransform.anchors.right = this.anchors.right * zoom;
        this.screenTransform.anchors.top = this.anchors.top * zoom;
        this.screenTransform.anchors.bottom = this.anchors.bottom * zoom;
        this.screenTransform.anchors.setCenter(this.anchors.getCenter());
    }
}
exports.AspectControl = AspectControl;
//# sourceMappingURL=AspectControl.js.map