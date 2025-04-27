"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MouseHint = void 0;
var __selfType = requireType("./MouseHint");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Utils_1 = require("./Utils");
var setAlphaForHierarchy = Utils_1.Utils.setAlphaForHierarchy;
const GizmoUtils_1 = require("./Gizmo/GizmoUtils");
let MouseHint = class MouseHint extends BaseScriptComponent {
    onAwake() {
        this.object = this.getSceneObject();
        this.screenTransform = this.object.getComponent("ScreenTransform");
        this.imageScreenTransform = this.image.getSceneObject().getParent().getComponent("ScreenTransform");
        this.material = this.image.mainMaterial;
        this.defaultCornerPivot = this.screenTransform.pivot;
        this.updateParentPointOffset();
        this.hide();
        this.textComponent.updatePriority = -1;
        // this.image.updatePriority = -1;
        // print("IMAGE UPDATE PRIORITY: " + this.image.updatePriority);
        // print("TEXT UPDATE PRIORITY: " + this.textComponent.updatePriority);
    }
    setText(msg) {
        this.textComponent.text = msg;
        this.adjustAspect();
    }
    show() {
        this.material.mainPass.shapeAlpha = 1;
        setAlphaForHierarchy(this.getSceneObject(), 1);
    }
    hide() {
        // Need it to be rendered so extent target from textComponent can update in time.
        // TODO: Add force update for TextComponent?
        this.material.mainPass.shapeAlpha = 0;
        setAlphaForHierarchy(this.getSceneObject(), 0);
    }
    enableStroke(value) {
        this.strokeObjects.forEach(obj => obj.enabled = value);
    }
    setRoundness(value) {
        this.material.mainPass.shapeRoundness = value;
    }
    updateFromMousePosition(mouseScreenPosition) {
        const parentPosition = this.screenTransform.screenPointToParentPoint(mouseScreenPosition);
        this.screenTransform.anchors.setCenter(parentPosition);
        this.screenTransform.pivot = this.defaultCornerPivot;
    }
    updateFromTargetScreenTransform(screenTransform) {
        const center = screenTransform.localPointToScreenPoint(vec2.zero());
        const corner = vec2.one();
        if (center.x > 0.5) {
            corner.x *= -1;
        }
        if (center.y < 0.5) {
            corner.y *= -1;
        }
        // print("CENTER: " + center);
        // print("CORNER: " + corner);
        const targetScreenPoint = screenTransform.localPointToScreenPoint(corner);
        // print("TARGET: " + targetScreenPoint);
        this.screenTransform.anchors.setCenter(this.screenTransform.screenPointToParentPoint(targetScreenPoint));
        this.screenTransform.pivot = this.getCornerPivot(corner);
        this.screenTransform.offsets.setCenter(this.getPosition(corner));
        this.adjustAspect();
    }
    adjustAspect() {
        const size = this.imageScreenTransform.localPointToWorldPoint(vec2.one())
            .sub(this.imageScreenTransform.localPointToWorldPoint(vec2.one().uniformScale(-1)));
        let x = 0;
        let y = 0;
        if (size.x < size.y) {
            y = 1;
            x = size.x / size.y;
        }
        else {
            x = 1;
            y = size.y / size.x;
        }
        x = Math.floor(x * 1000) / 1000;
        y = Math.floor(y * 1000) / 1000;
        this.material.mainPass.shapeWidthX = x;
        this.material.mainPass.shapeHeightY = y;
    }
    getCornerPivot(corner) {
        const newPivot = this.screenTransform.pivot;
        newPivot.x = Math.abs(newPivot.x) * corner.x;
        newPivot.y = Math.abs(newPivot.y) * corner.y;
        return newPivot;
    }
    getPosition(corner) {
        const position = this.screenTransform.offsets.getCenter();
        position.x = Math.abs(position.x) * corner.x;
        position.y = Math.abs(position.y) * corner.y;
        return position;
    }
    updateParentPointOffset() {
        this.parentPointOffset = GizmoUtils_1.GizmoUtils.localPointToParentPoint(this.screenTransform, vec2.zero())
            .sub(GizmoUtils_1.GizmoUtils.localPointToParentPoint(this.screenTransform, vec2.one()));
    }
    __initialize() {
        super.__initialize();
        this.parentPointOffset = vec2.zero();
        this.defaultCornerPivot = vec2.zero();
    }
};
exports.MouseHint = MouseHint;
exports.MouseHint = MouseHint = __decorate([
    component
], MouseHint);
//# sourceMappingURL=MouseHint.js.map