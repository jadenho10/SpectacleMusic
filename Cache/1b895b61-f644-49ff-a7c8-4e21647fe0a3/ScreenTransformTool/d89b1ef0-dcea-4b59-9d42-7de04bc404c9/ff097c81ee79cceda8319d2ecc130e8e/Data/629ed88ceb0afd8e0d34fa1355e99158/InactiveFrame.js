"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var InactiveFrame_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.InactiveFrame = void 0;
var __selfType = requireType("./InactiveFrame");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let InactiveFrame = InactiveFrame_1 = class InactiveFrame extends BaseScriptComponent {
    onAwake() {
        this.material = this.materialRef.clone();
        this.sides.forEach((side) => {
            side.mainMaterial = this.material;
            this.sideTransforms.push(side.getSceneObject().getParent().getComponent("ScreenTransform"));
        });
        this.updateDefaultOffset();
        this.setHoveEvent();
        this.hide();
    }
    setInteractionCamera(camera) {
        return;
        this.interactionComponent.setCamera(camera);
    }
    setOnHover(cb) {
        this.onHoverCallback = cb;
    }
    setInactive() {
        this.material.mainPass.baseColor = InactiveFrame_1.INACTIVE_COLOR;
    }
    getLayerSet() {
        return this.sceneObject.layer;
    }
    setLayerSet(layerSet) {
        this.sceneObject.layer = layerSet;
    }
    setScale(scale) {
        this.sideTransforms.forEach((screenTransform, idx) => {
            const offset = screenTransform.offsets;
            offset.top = Math.abs(offset.top) > this.EPS ? this.defaultOffsets[idx] * scale : 0;
            offset.left = Math.abs(offset.left) > this.EPS ? this.defaultOffsets[idx] * scale : 0;
            offset.right = Math.abs(offset.right) > this.EPS ? this.defaultOffsets[idx] * scale : 0;
            offset.bottom = Math.abs(offset.bottom) > this.EPS ? this.defaultOffsets[idx] * scale : 0;
            screenTransform.offsets = offset;
        });
    }
    hide() {
        this.sides.forEach(side => side.enabled = false);
    }
    show() {
        this.sides.forEach(side => side.enabled = true);
    }
    copy() {
        const parent = this.sceneObject.getParent();
        const copyObject = parent.copyWholeHierarchy(this.sceneObject);
        return copyObject.getComponent("ScriptComponent");
    }
    // updateParentLayer(): void {
    //     if (isNull(this.parent)) {
    //         return;
    //     }
    //     this.parent.layer = this.parent.layer.union(this.getLayerSet().except());
    // }
    setParent(parent) {
        this.sceneObject.setParent(parent);
    }
    setLayer(layer) {
        if (this.sceneObject.hasParent()) {
            const parent = this.sceneObject.getParent();
            parent.layer = parent.layer.union(layer);
        }
        this.sides.forEach(sideImage => sideImage.getSceneObject().layer = layer);
    }
    destroy() {
        if (isNull(this.sceneObject)) {
            return;
        }
        try { // Check above doesn't catch that the object is invalid :(
            this.sceneObject.destroy();
        }
        catch (e) {
            return; // TODO: Figure out something else instead of muting the error
        }
    }
    isValid() {
        return !isNull(this.sceneObject) && !this.sideTransforms.some(obj => isNull(obj));
    }
    updateDefaultOffset() {
        this.defaultOffsets = [];
        this.sideTransforms.forEach(screenTransform => {
            const offsets = screenTransform.offsets;
            this.defaultOffsets.push(offsets.left + offsets.right + offsets.top + offsets.bottom);
        });
    }
    setHoveEvent() {
        var _a;
        return;
        (_a = this.interactionComponent.onHover) === null || _a === void 0 ? void 0 : _a.add(() => {
            this.material.mainPass.baseColor = InactiveFrame_1.ACTIVE_COLOR;
            this.onHoverCallback && this.onHoverCallback();
        });
    }
    __initialize() {
        super.__initialize();
        this.EPS = 1e-3;
        this.sideTransforms = [];
        this.defaultOffsets = [];
        this.onHoverCallback = null;
    }
};
exports.InactiveFrame = InactiveFrame;
InactiveFrame.INACTIVE_COLOR = new vec4(162 / 255, 162 / 255, 162 / 255, 67 / 255);
InactiveFrame.ACTIVE_COLOR = new vec4(38 / 255, 146 / 255, 215 / 255, 67 / 255);
exports.InactiveFrame = InactiveFrame = InactiveFrame_1 = __decorate([
    component
], InactiveFrame);
//# sourceMappingURL=InactiveFrame.js.map